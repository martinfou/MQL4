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

public:
                     StochasticPop();
                    ~StochasticPop();

   //+------------------------------------------------------------------+
   //| Let the application know if it is time to buy
   //+------------------------------------------------------------------+
   bool isInBuyScalpingZone()
     {
      double stoCurrent=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,0);
      if(stoCurrent>70&&stoCurrent<=100)
        {
         return true;
        }
      return false;
     }


   bool isOutScalpingZone()
     {
      double stoCurrent=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,0);
      if(stoCurrent<=70&&stoCurrent>=30)
        {
         return true;
        }
      else
        {
         return false;
        }
     }

   bool isInSellScalpingZone()
     {
      double stoCurrent=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,0);
      if(stoCurrent<30&&stoCurrent>=0)
        {
         return true;
        }
      return false;
     }

   bool isOutSellScalpingZone()
     {
      double stoCurrent=iStochastic(Symbol(),PERIOD_CURRENT,9,9,3,MODE_SMA,0,MODE_MAIN,0);
      if(stoCurrent>=30)
        {
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
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
StochasticPop::~StochasticPop()
  {
  }
//+------------------------------------------------------------------+
