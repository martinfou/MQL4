//+------------------------------------------------------------------+
//|                                                  PriceAction.mq4 |
//|                                          Copyright 2017, Compica |
//|                                          https://www.compica.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Compica"
#property link      "https://www.compica.com"
#property version   "1.00"
#property strict

int BULLISH = 1;
int BEARISH = -1;
int UNDECIDED = 0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
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
  Print("on tick");
  if(isNewBar()){
   double openPrice=Open[1]; 
   double closePrice=Close[1]; 
   double highPrice=High[1]; 
   double lowPrice=Low[1]; 
   int tradingDirection = isBullish(1);
   double topShadowLenght = topShadowLenght(1);
   double bodyLenght = bodyLenght(1);
    Comment(StringFormat("Open = %G \n Close = %G \n High = %G \n Low = %G \n Direction %G \nTopShadow %G \nBody %G",openPrice, closePrice,highPrice,lowPrice, tradingDirection, topShadowLenght,bodyLenght));
  }

  }
//+------------------------------------------------------------------+

bool isNewBar()
  {
   static datetime lastbar;
   datetime curbar=Time[0];
   if(lastbar!=curbar)
     {
      lastbar=curbar;
      Print("=== NEW BAR ===");
      return (true);
     }
   else
     {
      return(false);
     }
  }
  
  int isBullish(int shift)
  {
   if(Open[shift] < Close[shift]){
      return BULLISH;
   }
   if(Open[shift] > Close[shift]){
      return BEARISH;
   }
   
      return UNDECIDED;
  }
  
  double topShadowLenght(int shift){
   if(isBullish(shift)){
      return High[shift]-Close[shift];
   }
   if(!isBullish(shift)){
      return High[shift]-Open[shift];
   }
   
   return 0;
  }
  
  double bodyLenght(int shift){
    return MathAbs(Open[shift]-Close[shift]);
  }
  
   double bottomShadowLenght(int shift){
   if(isBullish(shift)){
      return Open[shift]-Low[shift];
   }
   if(!isBullish(shift)){
      return Close[shift]-Low[shift];
   }
   return 0;
   }
//+------------------------------------------------------------------+
