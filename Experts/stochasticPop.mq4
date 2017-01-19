//+------------------------------------------------------------------+
//|                                                stochasticPop.mq4 |
//|                                          Copyright 2017, Compica |
//|                                          https://www.compica.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Compica"
#property link      "https://www.compica.com"
#property version   "1.00"
#property strict

#include "StochasticPop.mqh"
#include "Utils.mqh"

input double Lots=0.01;

Utils utils;
StochasticPop stocPop;
//+------------------------------------------------------------------+
//|  Initialise variables at startup                                 |
//+------------------------------------------------------------------+
int OnInit()
  {
   utils.setStartOfDayAccountBalance();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   utils.isTimeToTrade();

   if(OrdersTotal()<1 && utils.isNewBar())
     {
      if(stocPop.isInScalpingZone())
        {
         stocPop.setTicket(OrderSend(NULL,OP_BUY,Lots,Ask,3,Ask-0.00100,Ask+0.00020,"My order",16384,0,clrGreen));
        }
     }
   if(stocPop.isOutScalpingZone())
     {
      utils.closeAllOrders();
     }
  }

//+------------------------------------------------------------------+
