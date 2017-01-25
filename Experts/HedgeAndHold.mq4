//+------------------------------------------------------------------+
//|                                                 HedgeAndHold.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "Utils.mqh"

input double takeProfits=0.0005;
input double Lots=0.01;
Utils utils;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   buy();
   sell();

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
//---
   if(utils.isNewBar())
     {

      if(OrdersBuyTotal()==OrdersSellTotal())
        {
         sell();
         buy();
        }
      while(OrdersBuyTotal()!=OrdersSellTotal())
        {
         if(OrdersBuyTotal()>OrdersSellTotal())
           {
            sell();
           }
         if(OrdersSellTotal()<OrdersBuyTotal())
           {
            buy();

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
void buy()
  {
   OrderSend(Symbol(),OP_BUY,Lots,Ask,0,NULL,Ask+takeProfits,"Buy",911,0,Green);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void sell()
  {
   OrderSend(Symbol(),OP_SELL,Lots,Bid,0,NULL,Bid-takeProfits,"Sell",911,0,Red);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OrdersBuyTotal()
  {

   int     countOrdersBuy=0;

   for(int i=0; i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_BUY)
              {
               countOrdersBuy++;
              }

           }
        }

     }

   return countOrdersBuy;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OrdersSellTotal()
  {
   int     countOrdersSell=0;

   for(int i=0; i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_SELL)
              {
               countOrdersSell++;
              }

           }
        }

     }

   return countOrdersSell;
  }
//+------------------------------------------------------------------+
