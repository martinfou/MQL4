//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2016, Compica Inc"
#property link        "http://www.mql4.com"
#property description "My first robot"

#import "BarStats.mq4"
bool IsNewBar();

#define MAGICMA  20131111

//--- Inputs
input double Lots=0.01;
input double TakeProfitInPips=0.00910;
input double TakeLossInPips=0.00910;
input int ConcurrentOrders=3;

int barcounter=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

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
   if(modemain<10 && modesignal<10)
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
   if(modemain>90 && modesignal>90)
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

   if(IsNewBar())
     {
     
     double val=iCustom(NULL,0,"Heiken Ashi",13,1,0);
     Print("val = " + val);
      if(OrdersTotal()<ConcurrentOrders)
        {
         if(isStocaticSignalBuy())
           {
            buy();
           }
         if(isStocaticSignalSell())
           {
            sell();
           }
        }
        Print("I have that many orders open "+OrdersTotal());
     }
  }
//+------------------------------------------------------------------+
