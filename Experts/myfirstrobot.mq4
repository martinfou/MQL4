//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"
#property description "Moving Average sample expert advisor"

#define MAGICMA  20131111
//--- Inputs
input double Lots          =0.01;
input double MaximumRisk   =0.02;
input double DecreaseFactor=3;
input int    MovingPeriod  =12;
input int    MovingShift   =6;

bool buySignal1 = false;
bool buySignal2 = false;
bool sellSignal1 = false;
bool sellSignal2 = false;

int barcounter=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isBuySignal1()
  {
   double ma7=iMA(NULL,0,7,0,MODE_EMA,PRICE_CLOSE,0);
   double ma17=iMA(NULL,0,17,0,MODE_EMA,PRICE_CLOSE,0);
   double ma7Past=iMA(NULL,0,7,0,MODE_EMA,PRICE_CLOSE,1);
   double ma17Past=iMA(NULL,0,17,0,MODE_EMA,PRICE_CLOSE,1);
   if(ma7>=ma17 && ma7Past<ma17Past)
     {
      return true;
        }else{
      return false;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void printPringCurrentCandle()
  {
   double OpenPrice=Open[1];
   double ClosePrice=Close[1];
   double HighPrice=High[1];
   double LowPrice=Low[1];

   Print("openprice : "+OpenPrice);

  }
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
   double takeProfit=askPrice+0.00015;
   double stopLost=askPrice-0.00030;
   int ticket=OrderSend(Symbol(),OP_BUY,Lots,askPrice,3,stopLost,takeProfit,"this is a trade comment",MAGICMA,0,Blue);
   Print("I just bought "+ticket);
   return ticket;
  }
  
  int sell()
  {
   double bidPrice=Bid;
   double takeProfit=bidPrice-0.00015;
   double stopLost=bidPrice+0.00030;
   int ticket=OrderSend(Symbol(),OP_SELL,Lots,bidPrice,3,stopLost,takeProfit,"this is a trade comment",MAGICMA,0,Red);
   Print("I just bought "+ticket);
   return ticket;
  }
  
  
  
  
//+------------------------------------------------------------------+
//| OnTick function                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   buySignal1=isBuySignal1();
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
