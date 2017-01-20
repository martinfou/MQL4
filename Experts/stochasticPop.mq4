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
input double takeProfitPips=0.00020;

bool buyToggle=FALSE;

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


   if(stocPop.isInBuyScalpingZone())
     {
     if(buyToggle==true){
      Print("*** BUY ***", buyToggle);
      buyToggle=false;
      stocPop.setTicket(OrderSend(Symbol(),OP_BUY,Lots,Ask,1,NULL,Ask+takeProfitPips,"My order",16384,0,Red));
}
     }

   if(stocPop.isInSellScalpingZone())
     {
     if(buyToggle==false){
      buyToggle=true;
      stocPop.setTicket(OrderSend(Symbol(),OP_SELL,Lots,Bid,1,NULL,Bid-takeProfitPips,"My order",99999,0,Green));
      }
     }

   if(OrdersTotal()>0 && (stocPop.isOutScalpingZone()))
     {
      utils.closeAllOrders();
     }

  }

//+------------------------------------------------------------------+
