//+------------------------------------------------------------------+
//|                                                        Utils.mqh |
//|                                          Copyright 2017, Compica |
//|                                          https://www.compica.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Compica"
#property link      "https://www.compica.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|   Utility Class for EA plumbing                                  |
//+------------------------------------------------------------------+
class Utils
  {
private:
   bool              isTradingAllowed;
   double            startOfDayAccountBalance;
public:
                     Utils();
                    ~Utils();

   
   void isTimeToTrade(){
      startOfDay();
      endOfDay();
   }
   
   //+------------------------------------------------------------------+
   //|   Detetect Start Of Day and Save Account Balance                 |
   //+------------------------------------------------------------------+
   void startOfDay()
     {
      if(isTradingAllowed==false && Hour()==0 && Minute()>0)
        {
         this.isTradingAllowed=true;
         setStartOfDayAccountBalance();
         Print("=== START OF DAY === Account Balance ==>  ",this.startOfDayAccountBalance);
        }
     }
   //+------------------------------------------------------------------+     
   //|   Method to detect the end of days and close all positions.      |
   //+------------------------------------------------------------------+
   void endOfDay()
     {
      if(isTradingAllowed==true && Hour()==23 && Minute()>=45)
        {
         for(int i=0;i<OrdersTotal();i++)
           {
            int ticket = OrderSelect(i,SELECT_BY_POS);
            int status = OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Red);
           }
         this.isTradingAllowed=false;
         double profitOrLoss=startOfDayAccountBalance-AccountBalance();
         Print("===  END OF DAY   === Profit / Loss  ==> "+(string)profitOrLoss);
        }
     }

   //+------------------------------------------------------------------+
   //| Sets the Account Balance at the start of the day.                |
   //+------------------------------------------------------------------+
   void setStartOfDayAccountBalance()
     {
      this.startOfDayAccountBalance=AccountBalance();
      Print("=== START OF DAY === Account Balance ==>  ",this.startOfDayAccountBalance);
     }

   //+------------------------------------------------------------------+
   //| Detect if a new bar is created.                                  |
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
  };
//+------------------------------------------------------------------+
//| Constructor setting attributes on class creations                |
//+------------------------------------------------------------------+
Utils::Utils()
  {
   isTradingAllowed=true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Utils::~Utils()
  {
  }
//+------------------------------------------------------------------+
