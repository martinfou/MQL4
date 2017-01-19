//+------------------------------------------------------------------+
//|                                                StochasticPop.mqh |
//|                                          Copyright 2017, Compica |
//|                                          https://www.compica.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Compica"
#property link      "https://www.compica.com"
#property version   "1.00"
#property strict

#include "Utils.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class StochasticPop
  {
private:
   int               ticket;
   double            lastStoK;
   bool              inBuyScalpingZone;
   Utils             utils;

public:
                     StochasticPop();
                    ~StochasticPop();

   //+------------------------------------------------------------------+
   //| Let the application know if it is time to buy
   //+------------------------------------------------------------------+
   bool isInBuyScalpingZone()
     {
      double stoCurrent=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,1);
      double stoPrevious=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,2);
      if(stoCurrent>70 && this.inBuyScalpingZone==false)
        {
         this.inBuyScalpingZone=true;
         return true;
        }
      return false;
     }

   bool isOutBuyScalpingZone()
     {
      double stoCurrent=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,1);
      if(stoCurrent<=70&& this.inBuyScalpingZone==true)
        {
        this.inBuyScalpingZone=false;
         return true;
        }
      else
        {
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
   this.inBuyScalpingZone=false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
StochasticPop::~StochasticPop()
  {
  }
//+------------------------------------------------------------------+
