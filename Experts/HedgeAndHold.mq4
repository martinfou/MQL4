//+------------------------------------------------------------------+
//|                                                 HedgeAndHold.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.0"
#property strict

#include "Utils.mqh"

input double takeProfits=0.0005;
input double stopLoss=0.0035;
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
//|                                                                  |
//+------------------------------------------------------------------+
bool isNewBar()
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
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(isNewBar())
     {
      if(OrdersTotal()<10)
        {
         buy();
         sell();
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
   int ticket = OrderSend(Symbol(),OP_BUY,Lots,Ask,0,Ask-stopLoss,Ask+takeProfits,"HedgeAndHoldBuy",911,0,Green);
   if(ticket <= 0){
    Print("Error trying to BUY #",GetLastError());
   }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void sell()
  {
   int ticket = OrderSend(Symbol(),OP_SELL,Lots,Bid,0,Bid+stopLoss,Bid-takeProfits,"HedgeAndHoldSell",911,0,Red);
   if(ticket <= 0){
    Print("Error trying to BUY #",GetLastError());
   }
  }
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
