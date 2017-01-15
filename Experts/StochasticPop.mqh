//+------------------------------------------------------------------+
//|                                                StochasticPop.mqh |
//|                                          Copyright 2017, Compica |
//|                                          https://www.compica.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Compica"
#property link      "https://www.compica.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class StochasticPop
  {
private:
   int               ticket;
   double            lastStoK;

public:
                     StochasticPop();
                    ~StochasticPop();

   //+------------------------------------------------------------------+
   //| Let the application know if it is time to buy
   //+------------------------------------------------------------------+
   bool isBuySignal()
     {
      double stoK=iStochastic(NULL,PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,0);
      if(stoK>71)
        {
        Print("buy signal"+(string)stoK);
        lastStoK=stoK;
         return true;
        }
      return false;
     }

   bool isSellSignal()
     {
     double stoK=iStochastic(NULL,PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,0);
     if(stoK<69&&lastStoK>stoK){
     
      Print("sell signal"+(string)stoK);
     
      return true;
      }
      else{
      return false;
      }
     }

   void setTicket(int _ticket)
     {
      this.ticket=_ticket;
     }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
StochasticPop::StochasticPop()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
StochasticPop::~StochasticPop()
  {
  }
//+------------------------------------------------------------------+
