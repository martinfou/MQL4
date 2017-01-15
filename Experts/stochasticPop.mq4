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
   utils.startOfDay();
   utils.endOfDay();

   if(OrdersTotal()<1)
     {
      if(stocPop.isBuySignal())
        {
         stocPop.setTicket(OrderSend(Symbol(),OP_BUY,Lots,Ask,3,NULL,Ask+0.0002,"My order",16384,0,clrGreen));

        }
     }
   if(OrdersTotal()>0)
     {

     }
  }
//+------------------------------------------------------------------+
