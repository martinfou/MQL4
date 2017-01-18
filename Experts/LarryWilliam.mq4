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

#define MAGICMA  911
//--- Inputs
input double Lots=0.01;

//--- Utility Class
Utils utils;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   utils.setStartOfDayAccountBalance();
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
   utils.isTimeToTrade();
   if(utils.isNewBar())
     {

      if(OrdersTotal()>0 && isCloseBuySignal())
        {
         Print("isClose signal true");
         for(int i=0; i<OrdersTotal(); i++)
           {
            OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            OrderClose(OrderTicket(),OrderLots(),Bid,3,MediumSeaGreen);
           }
        }
      if(OrdersTotal()<1 && isBuySignal())
        {
         Print("buy time");
         OrderSend(Symbol(),OP_BUY,Lots,Ask,3,NULL,NULL,"My order",911,0,clrGreen);
        }

     }
  }
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
double getLowSma(int shift)
  {
   return iMA(Symbol(),PERIOD_CURRENT, 3,0,MODE_SMA,PRICE_LOW,shift);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isCloseBuySignal()
  {
   if(iHigh(Symbol(),PERIOD_CURRENT,1)>getHighSma(1))
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
bool isBuySignal()
  {
   if((iClose(Symbol(),PERIOD_CURRENT,1)<getLowSma(1)))
     {
      return true;
     }
   else
     {
      return false;
     }
  }
//+------------------------------------------------------------------+
