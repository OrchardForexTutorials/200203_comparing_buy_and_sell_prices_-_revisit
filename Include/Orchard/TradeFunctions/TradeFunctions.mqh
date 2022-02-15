//+------------------------------------------------------------------+
//|                                                        Trade.mqh |
//|                                    Copyright 2020, Orchard Forex |
//|                                         https://orchardforex.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Orchard Forex"
#property link      "https://orchardforex.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+


//
//	Using a class
//
class CCompare {

private:

	ENUM_ORDER_TYPE	TradeType;
	
public:

	CCompare()																		{};
	CCompare(ENUM_ORDER_TYPE tradeType)										{	TradeType	=	tradeType;	};
	~CCompare()																		{};
	
	bool	gt(double v1, double v2)											{	return(gt(v1, v2, TradeType));	};
	bool	gt(double v1, double v2, ENUM_ORDER_TYPE tradeType)		{	return( (tradeType%2==ORDER_TYPE_BUY && v1>v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1<v2)	);	};

	bool	ge(double v1, double v2)											{	return(ge(v1, v2, TradeType));	};
	bool	ge(double v1, double v2, ENUM_ORDER_TYPE tradeType)		{	return( (tradeType%2==ORDER_TYPE_BUY && v1>=v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1<=v2)	);	};

	bool	lt(double v1, double v2)											{	return(lt(v1, v2, TradeType));	};
	bool	lt(double v1, double v2, ENUM_ORDER_TYPE tradeType)		{	return( (tradeType%2==ORDER_TYPE_BUY && v1<v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1>v2)	);	};

	bool	le(double v1, double v2)											{	return(le(v1, v2, TradeType));	};
	bool	le(double v1, double v2, ENUM_ORDER_TYPE tradeType)		{	return( (tradeType%2==ORDER_TYPE_BUY && v1<v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1>v2)	);	};

	//
	//	Math, add and subtract
	//
	double	add(double v1, double v2)										{	return( (TradeType%2==ORDER_TYPE_BUY) ? v1+v2 : v1-v2);	};
	double	sub(double v1, double v2)										{	return( (TradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v1+v2);	};
	double	dif(double v1, double v2)										{	return( (TradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v2-v1);	};
	double	add(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY) ? v1+v2 : v1-v2);	};
	double	sub(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v1+v2);	};
	double	dif(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v2-v1);	};

	double	openPrice()															{ return(openPrice(Symbol(),	TradeType));	};
	double	openPrice(string symbol)										{ return(openPrice(symbol,		TradeType));	};
	double	openPrice(ENUM_ORDER_TYPE tradeType)						{ return(openPrice(Symbol(),	tradeType));	};
	double	openPrice(string symbol, ENUM_ORDER_TYPE tradeType)	{ return((tradeType%2==ORDER_TYPE_BUY) ?
																										MarketInfo(symbol, MODE_ASK) : MarketInfo(symbol, MODE_BID));	}

	double	closePrice()														{ return(closePrice(Symbol(),	TradeType));	};
	double	closePrice(string symbol)										{ return(closePrice(symbol,	TradeType));	};
	double	closePrice(ENUM_ORDER_TYPE tradeType)						{ return(closePrice(Symbol(),	tradeType));	};
	double	closePrice(string symbol, ENUM_ORDER_TYPE tradeType)	{ return((tradeType%2==ORDER_TYPE_BUY) ?
																										MarketInfo(symbol, MODE_BID) : MarketInfo(symbol, MODE_ASK));	}
};

//
//	Using macros
//
// _GT,_GE,_LT,_LE
// Read _GT(a,b,type) as a>b with respect to trade type
#define 	_GT(v1, v2, tradeType)	( (tradeType%2==ORDER_TYPE_BUY && v1>v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1<v2)	)
#define 	_GE(v1, v2, tradeType)	( (tradeType%2==ORDER_TYPE_BUY && v1>=v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1<=v2)	)
#define 	_LT(v1, v2, tradeType)	( (tradeType%2==ORDER_TYPE_BUY && v1<v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1>v2)	)
#define 	_LE(v1, v2, tradeType)	( (tradeType%2==ORDER_TYPE_BUY && v1<v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1>v2)	)

//
//	Math, add and subtract
//
#define	_Add(v1, v2, tradeType)	(	(tradeType%2==ORDER_TYPE_BUY) ? v1+v2 : v1-v2)
#define	_Sub(v1, v2, tradeType)	(	(tradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v1+v2)
#define	_Dif(v1, v2, tradeType)	(	(tradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v2-v1)


#define	_OpenPrice(symbol, tradeType)		((tradeType%2==ORDER_TYPE_BUY) ? MarketInfo(symbol, MODE_ASK) : MarketInfo(symbol, MODE_BID))
#define	_ClosePrice(symbol, tradeType)	((tradeType%2==ORDER_TYPE_BUY) ? MarketInfo(symbol, MODE_BID) : MarketInfo(symbol, MODE_ASK))

//
//	Using functions
//
// GT,GE,LT,LE
// Read GT(a,b,type) as a>b with respect to trade type
bool	GT(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY && v1>v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1<v2)	);	}
bool	GE(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY && v1>=v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1<=v2)	);	}
bool	LT(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY && v1<v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1>v2)	);	}
bool	LE(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY && v1<=v2)	||	(tradeType%2==ORDER_TYPE_SELL && v1>=v2)	);	}

//
//	Math, add and subtract
//
double	Add(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY) ? v1+v2 : v1-v2);	}
double	Sub(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v1+v2);	}
double	Dif(double v1, double v2, ENUM_ORDER_TYPE tradeType)	{	return( (tradeType%2==ORDER_TYPE_BUY) ? v1-v2 : v2-v1);	}

//
//	Open and close price, for buy open=ask, close=bid, for sell open=bid, close=ask
//
double	OpenPrice(ENUM_ORDER_TYPE tradeType)						{ return(OpenPrice(Symbol(), tradeType));		}
double	OpenPrice(string symbol, ENUM_ORDER_TYPE tradeType)	{ return((tradeType%2==ORDER_TYPE_BUY) ?
																									MarketInfo(symbol, MODE_ASK) : MarketInfo(symbol, MODE_BID));	}
double	ClosePrice(ENUM_ORDER_TYPE tradeType)						{ return(ClosePrice(Symbol(), tradeType));	}
double	ClosePrice(string symbol, ENUM_ORDER_TYPE tradeType)	{ return((tradeType%2==ORDER_TYPE_BUY) ?
																									MarketInfo(symbol, MODE_BID) : MarketInfo(symbol, MODE_ASK));	}
	

//
//	ApplyTrailingStop
//	Used to apply a trailing stop to matching trades
//
//	symbol - required, only apply to trades for the selected symbol
//	magicNumber - required, use 0 for manually placed trades, otherwise the magic number of the EA
//	tradeType - required, only applies the trailing stop to the same order type
//	price	-	required, sets the trailing top to the specified price
//
void     ApplyTrailingStop(string symbol, int magicNumber, ENUM_ORDER_TYPE tradeType, double price) {

	bool	result;
   for (int i=OrdersTotal()-1; i>=0; i--) {
   	if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
   		if (OrderSymbol()==symbol && OrderMagicNumber()==magicNumber && OrderType()==tradeType) {
   			if (tradeType==ORDER_TYPE_BUY) {
   				if (OrderStopLoss()==0 || OrderStopLoss()<price || price==0) {
	   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
					}
   			} else if (tradeType==ORDER_TYPE_SELL) {
   				if (OrderStopLoss()==0 || OrderStopLoss()>price || price==0) {
	   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
					}
   			} else {
   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
   			}
   		}
   	}
   }
   
   return;
   
}

void     ApplyTrailingStop_Functions(string symbol, int magicNumber, ENUM_ORDER_TYPE tradeType, double price) {

	if (tradeType!=ORDER_TYPE_BUY && tradeType!=ORDER_TYPE_SELL) {	// only needed to exclude limit and stop orders
		return;
	}

	bool	result;
   for (int i=OrdersTotal()-1; i>=0; i--) {
   	if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
   		if (OrderSymbol()==symbol && OrderMagicNumber()==magicNumber && OrderType()==tradeType) {
				if (OrderStopLoss()==0 || LT(OrderStopLoss(), price, tradeType) || price==0) {
   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
				}
   		}
   	}
   }
   
   return;
   
}

void     ApplyTrailingStop_Macros(string symbol, int magicNumber, ENUM_ORDER_TYPE tradeType, double price) {

	if (tradeType!=ORDER_TYPE_BUY && tradeType!=ORDER_TYPE_SELL) {	// only needed to exclude limit and stop orders
		return;
	}

	bool	result;
   for (int i=OrdersTotal()-1; i>=0; i--) {
   	if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
   		if (OrderSymbol()==symbol && OrderMagicNumber()==magicNumber && OrderType()==tradeType) {
				if (OrderStopLoss()==0 || _LT(OrderStopLoss(), price, tradeType) || price==0) {
   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
				}
   		}
   	}
   }
   
   return;
   
}

void     ApplyTrailingStop_Objects(string symbol, int magicNumber, ENUM_ORDER_TYPE tradeType, double price) {

	if (tradeType!=ORDER_TYPE_BUY && tradeType!=ORDER_TYPE_SELL) {	// only needed to exclude limit and stop orders
		return;
	}

	CCompare	compare;
	bool	result;
   for (int i=OrdersTotal()-1; i>=0; i--) {
   	if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
   		if (OrderSymbol()==symbol && OrderMagicNumber()==magicNumber && OrderType()==tradeType) {
				if (OrderStopLoss()==0 || compare.lt(OrderStopLoss(), price, tradeType) || price==0) {
   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
				}
   		}
   	}
   }
   
   return;
   
}

void     ApplyTrailingStop_Objects_v2(string symbol, int magicNumber, ENUM_ORDER_TYPE tradeType, double price) {

	if (tradeType!=ORDER_TYPE_BUY && tradeType!=ORDER_TYPE_SELL) {	// only needed to exclude limit and stop orders
		return;
	}

	CCompare	compare(tradeType);
	bool	result;
   for (int i=OrdersTotal()-1; i>=0; i--) {
   	if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
   		if (OrderSymbol()==symbol && OrderMagicNumber()==magicNumber && OrderType()==tradeType) {
				if (OrderStopLoss()==0 || compare.lt(OrderStopLoss(), price) || price==0) {
   				result = OrderModify(OrderTicket(), OrderOpenPrice(), price, OrderTakeProfit(), OrderExpiration());
				}
   		}
   	}
   }
   
   return;
   
}

double	GetTrailingStopPrice(string symbol, ENUM_ORDER_TYPE tradeType, double gap) {

	if (tradeType%2==ORDER_TYPE_BUY) {
		return(NormalizeDouble(MarketInfo(symbol, MODE_BID)-gap, (int)MarketInfo(symbol, MODE_DIGITS)));
	}
	else if (tradeType%2==ORDER_TYPE_SELL) {
		return(NormalizeDouble(MarketInfo(symbol, MODE_ASK)+gap, (int)MarketInfo(symbol, MODE_DIGITS)));
	}
	
	return(0);
	
}

double	GetTrailingStopPrice_Functions(string symbol, ENUM_ORDER_TYPE tradeType, double gap) {

	return(NormalizeDouble(Sub(ClosePrice(symbol, tradeType), gap, tradeType), (int)MarketInfo(symbol, MODE_DIGITS)));
	
}

double	GetTrailingStopPrice_Macros(string symbol, ENUM_ORDER_TYPE tradeType, double gap) {

	return(NormalizeDouble(_Sub(_ClosePrice(symbol, tradeType), gap, tradeType), (int)MarketInfo(symbol, MODE_DIGITS)));
	
}

double	GetTrailingStopPrice_Objects(string symbol, ENUM_ORDER_TYPE tradeType, double gap) {

	CCompare	compare;
	return(NormalizeDouble(compare.sub(compare.closePrice(symbol, tradeType), gap, tradeType), (int)MarketInfo(symbol, MODE_DIGITS)));
	
}

double	GetTrailingStopPrice_Objects_v2(string symbol, ENUM_ORDER_TYPE tradeType, double gap) {

	CCompare	compare(tradeType);
	return(NormalizeDouble(compare.sub(compare.closePrice(symbol), gap), (int)MarketInfo(symbol, MODE_DIGITS)));
	
}


