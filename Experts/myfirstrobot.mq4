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
input double Lots          =0.01;
input double TakeProfitInPips    =0.00070;
input double TakeLossInPips      =0.00020;

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
   if(modemain<20 && modesignal<20)
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
   if(modemain>80 && modesignal>80)
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
   Print("I just bought "+ticket);
   return ticket;
  }
  
  int sell()
  {
   double bidPrice=Bid;
   double takeProfit=bidPrice-TakeProfitInPips;
   double stopLost=bidPrice+TakeLossInPips;
   int ticket=OrderSend(Symbol(),OP_SELL,Lots,bidPrice,3,stopLost,takeProfit,"this is a trade comment",MAGICMA,0,Red);
   Print("I just bought "+ticket);
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
      if(isStocaticSignalBuy())
        {
         buy();
        }
      if(isStocaticSignalSell())
      {
         sell();
      }

     }
  }
//+------------------------------------------------------------------+
