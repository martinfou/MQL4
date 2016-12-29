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
int barcounter = 0;

//test candle
void printPringCurrentCandle(){
double OpenPrice=Open[1]; 
double ClosePrice=Close[1]; 
double HighPrice=High[1]; 
double LowPrice=Low[1]; 

Print("openprice : " + OpenPrice);

}
bool newBar(){
   static datetime lastbar;
   datetime curbar = Time[0];
   if(lastbar!=curbar)
   {
      lastbar=curbar;
      return (true);
   }
   else{
      return(false);
   }
}

//+------------------------------------------------------------------+
//| OnTick function                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   Print("bars " + Bars);
   if(newBar()){
      barcounter=barcounter+1;
   }
  }
//+------------------------------------------------------------------+
