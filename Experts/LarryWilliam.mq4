//+------------------------------------------------------------------+
//|                                                 LarryWilliam.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "Utils.mqh"

#define        WIDTH  800     // Image width to call ChartScreenShot()
#define        HEIGHT 600     // Image height to call ChartScreenShot()

#define MAGICMA  911
//--- Inputs
input double Lots=0.01;
bool isOkToTrade=true;
//--- Utility Class
Utils utils;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   utils.setStartOfDayAccountBalance();
   Print("Preparation of the Expert Advisor is completed");

   if(ChartScreenShot(0,"test.png",WIDTH,HEIGHT,ALIGN_LEFT))
      Print("We've saved the screenshot ","test");

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

   double Ask,Bid;
   int Spread;
   Ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   Bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   Spread=SymbolInfoInteger(Symbol(),SYMBOL_SPREAD);
   
//--- Output values in three lines
   Comment(StringFormat("Show prices\nAsk = %G\nBid = %G\nSpread = %d\nisOkToTrade = %g \nisTrending = %g ",Ask,Bid,Spread,isOkToTrade,isTrendingUp()));

   utils.isTimeToTrade();

   if(utils.isNewBar())
     {
      isOkToTrade=true;
     }

   if(OrdersTotal()>0 && isCloseBuySignal() && isOkToTrade==true)
     {
      Print("isClose signal true");
      for(int i=0; i<OrdersTotal(); i++)
        {
         isOkToTrade=false;
         OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         OrderClose(OrderTicket(),OrderLots(),Bid,3,MediumSeaGreen);
        }
     }

   if(OrdersTotal()<1 && isOkToTrade==true)
     {
      if(isOkToTrade)
        {
         if(isBuySignal())
           {
            if(isTrendingUp())
              {
               Print("buy time");
               isOkToTrade=false;
               OrderSend(Symbol(),OP_BUY,Lots,Ask,3,NULL,NULL,"My order",911,0,clrGreen);
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getHighSma(int shift)
  {
   return iMA(Symbol(),PERIOD_CURRENT, 3,0,MODE_SMA,PRICE_HIGH,shift);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getLowSma(int shift)
  {
   return iMA(Symbol(),PERIOD_CURRENT, 3,0,MODE_SMA,PRICE_LOW,shift);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isCloseBuySignal()
  {
   if(iHigh(Symbol(),PERIOD_CURRENT,0)>getHighSma(0))
     {
      isOkToTrade=false;
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isBuySignal()
  {
   if(( iLow(Symbol(),PERIOD_CURRENT,0)<getLowSma(0)))
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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isTrendingUp()
  {
   if(iMACD(Symbol(),0,3,5,3,PRICE_CLOSE,MODE_MAIN,0)>0)
     {
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
