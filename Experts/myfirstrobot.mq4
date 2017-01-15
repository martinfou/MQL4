//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2016, Compica Inc"
#property link        "http://www.mql4.com"
#property description "My first robot"

#define MAGICMA  20131111

//--- Inputs
input double Lots=0.01;
input double TakeProfitInPips=0.0010;
input double TakeLossInPips=0.0007;
input int ConcurrentOrders=300;
input int MaxTransactionPerBarCounter=1;
input int isStocaticSignalBuy=15;
input int isStocaticSignalSell=95;

int TransactionPerBarCounter=0;
bool lastTransactionWasBuy=false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool newBar()
  {
   static datetime lastbar;
   datetime curbar=Time[0];
   if(lastbar!=curbar)
     {
      lastbar=curbar;
      return (true);
     }
   else
     {
      return(false);
     }
  }
//+------------------------------------------------------------------+
//|                                                                   |
//+------------------------------------------------------------------+
bool isStocaticSignalBuy()
  {
   double modemain=iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,0);
   double modesignal=iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_SIGNAL,0);
   if(modemain<isStocaticSignalBuy && modesignal<isStocaticSignalBuy)
     {
      return true;
     }
   else
     {
      return false;
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isStocaticSignalSell()
  {
   double modemain=iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,0);
   double modesignal=iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_SIGNAL,0);
   if(modemain>isStocaticSignalSell && modesignal>isStocaticSignalSell)
     {
      return true;
     }
   else
     {
      return false;
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int buy()
  {
   double askPrice=Ask;
   double takeProfit=askPrice+TakeProfitInPips;
   double stopLost=askPrice-TakeLossInPips;
   int ticket=OrderSend(Symbol(),OP_BUY,Lots,askPrice,3,stopLost,takeProfit,"this is a trade comment",MAGICMA,0,Blue);
   TransactionPerBarCounter=TransactionPerBarCounter+1;
   lastTransactionWasBuy=true;
   return ticket;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sell()
  {
   double bidPrice=Bid;
   double takeProfit=bidPrice-TakeProfitInPips;
   double stopLost=bidPrice+TakeLossInPips;
   int ticket=OrderSend(Symbol(),OP_SELL,Lots,bidPrice,3,stopLost,takeProfit,"this is a trade comment",MAGICMA,0,Red);
   TransactionPerBarCounter=TransactionPerBarCounter+1;
   lastTransactionWasBuy=false;
   return ticket;
  }
//+------------------------------------------------------------------+
//| OnTick function                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   double ma7=iMA(NULL,0,7,0,MODE_EMA,PRICE_CLOSE,0);
   double ma17 = iMA(NULL,0,17,0,MODE_EMA,PRICE_CLOSE,0);
   double ma37 = iMA(NULL,0,37,0,MODE_EMA,PRICE_CLOSE,0);

   if(newBar())
     {
      TransactionPerBarCounter=0;
     }

   if(OrdersTotal()<ConcurrentOrders)
     {
      if(isStocaticSignalBuy() && lastTransactionWasBuy==false)
        {
         buy();
        }
      if(isStocaticSignalSell() && lastTransactionWasBuy==true)
        {
         sell();
        }
     }
  }
//+------------------------------------------------------------------+
