//+------------------------------------------------------------------+
//| ScalpingEA.mq4                                                   |
//| Forex Expert Advisor - Kundenprofil-optimiert                   |
//| Copyright 2025, Alexander Boß                                    |
//| https://www.b0ss.dev                                             |
//+------------------------------------------------------------------+
//| FOREX EDITION - Optimiert für EURUSD, GBPUSD, USDJPY, etc.    |
//| - 2-3 hochwertige Trades pro Tag                               |
//| - 1-2% Drawdown Management                                     |
//| - NY Open Focus (15:30 deutsche Zeit)                         |
//| - Handelszeiten-Information (keine Beschränkung)              |
//| - Höhere Gewinne pro Trade (RRR 2.5)                         |
//| - Professionelles Chart-Design                                |
//| - News-Filter (ein-/ausschaltbar)                            |
//| - Universelle Symbol-Unterstützung                           |
//+------------------------------------------------------------------+
#property copyright "Alexander Boß - www.b0ss.dev"
#property link      "https://www.b0ss.dev"
#property version   "2.25"
#property strict

//+------------------------------------------------------------------+
//| KUNDENPROFIL-OPTIMIERTE PARAMETER                              |
//+------------------------------------------------------------------+

// === GRUNDEINSTELLUNGEN ===
extern double LotSize = 0.01;                   // Lot-Größe pro Trade (Standard für 1:50-75 Hebel)
extern double RiskPercent = 1.0;                // Risiko in % pro Trade (professionell)
extern double AccountBalance = 1000.0;          // Referenz-Kontostand (professionell)
extern int MaxTradesPerDay = 3;                 // Max. Trades pro Tag (Empfehlung)
extern double RiskRewardRatio = 2.5;            // Risk-Reward Verhältnis (höhere Gewinne)
extern double MaxDrawdownPercent = 2.0;         // Max. Drawdown in %

// === HANDELSZEITEN (nur Information) ===
extern bool RestrictedTradingHours = true;     // Trading-Zeit Info anzeigen
extern int TradingStartHour = 15;               // Start: 15:45 deutsche Zeit
extern int TradingStartMinute = 45;
extern int TradingEndHour = 17;                 // Ende: 17:45 deutsche Zeit  
extern int TradingEndMinute = 45;
extern bool NYOpenFocus = true;                 // NY Open Focus (15:30 deutsche Zeit)
extern bool SundayTradingOnly = true;           // Wochenende Info

// === UNIVERSELLE SYMBOL-UNTERSTÜTZUNG ===
// Alle Symbole sind standardmäßig erlaubt - keine Beschränkungen

// === NEWS-FILTER ===
extern bool NewsFilter = false;                 // News-Filter (Kunde kann ein/ausschalten)
extern double MinSpread = 0.1;                  // Min. Spread für Trading (Pips)
extern double MaxSpread = 5.0;                  // Max. Spread für Trading (Pips) - realistisch für Live

// === TECHNISCHE PARAMETER ===
extern int SwingPeriod = 15;                    // Swing-Erkennung Periode
extern double VolumeMultiplier = 1.5;           // Volume-Filter (professionell)
extern double BreakoutThreshold = 0.0015;       // Breakout-Schwelle (0.15%)
extern bool UseATR_SL = true;                   // ATR-basierte Stop Loss
extern double ATR_Multiplier = 2.5;             // ATR Multiplikator für SL
extern int ATR_Period = 14;                     // ATR Periode

// === TAKE PROFIT & STOP LOSS ===
extern int SL_Points = 30;                      // Stop Loss in Pips (Forex)
extern int TP_Points = 60;                      // Take Profit in Pips (Forex)
extern int TP2_Points = 90;                     // Take Profit 2 in Pips (Forex)
extern int TrailingDistance = 20;               // Trailing Stop Distance in Pips

// === ALERTS & INTERFACE ===
extern bool EnableAlerts = true;                // Popup-Alerts aktivieren
extern bool EnableSounds = true;                // Sound-Alerts aktivieren
extern bool EnableDashboard = true;             // Dashboard anzeigen

// === VISUELLE EINSTELLUNGEN ===
extern bool ShowEntryArrows = true;             // Entry-Pfeile anzeigen
extern bool ShowExitArrows = true;              // Exit-Pfeile anzeigen
extern bool ShowSuccessSymbols = true;          // Erfolgs-Symbole anzeigen
extern bool ShowVolatilityZones = true;         // Volatilitäts-Zonen anzeigen

// === SOUND-DATEIEN ===
extern string SoundFileEntry = "alert.wav";     // Sound für Entry
extern string SoundFileExit = "alert2.wav";     // Sound für Exit
extern string SoundFileWin = "ok.wav";          // Sound für Gewinn
extern string SoundFileLoss = "timeout.wav";    // Sound für Verlust

// === TECHNISCHE INDIKATOREN ===
extern int RSI_Period = 14;                     // RSI Periode (Forex-Standard)
extern int RSI_Overbought = 70;                 // RSI Überkauft Level
extern int RSI_Oversold = 30;                   // RSI Überverkauft Level
extern int EMA_Fast = 8;                        // Schnelle EMA
extern int EMA_Medium = 21;                     // Mittlere EMA  
extern int EMA_Slow = 50;                       // Langsame EMA
extern int MACD_Fast = 12;                      // MACD Fast EMA
extern int MACD_Slow = 26;                      // MACD Slow EMA
extern int MACD_Signal = 9;                     // MACD Signal SMA

// === FOREX-SPEZIFISCHE PARAMETER ===
extern bool ForexMode = true;                   // Forex-Optimierungen aktivieren
extern double VolatilityFilter = 0.002;         // Volatilitäts-Filter (0.2% - professionell)

// === DASHBOARD-EINSTELLUNGEN ===
extern int DashboardX = 20;                     // Dashboard X-Position
extern int DashboardY = 30;                     // Dashboard Y-Position

// === SYSTEM-PARAMETER ===
extern int MagicNumber = 54321;                 // Eindeutige EA-Kennung (unterschiedlich von Krypto)
extern int Slippage = 3;                        // Slippage Toleranz

//+------------------------------------------------------------------+
//| GLOBALE VARIABLEN                                               |
//+------------------------------------------------------------------+

// Zeitsteuerung
datetime LastBarTime = 0;

// Trading-Statistiken
int TradesToday = 0;
int WinningTrades = 0;
int LosingTrades = 0;
int TotalTrades = 0;
double TotalProfit = 0;
double CurrentDrawdown = 0;
double MaxDrawdown = 0;
datetime LastTradeTime = 0;
datetime LastTradingDay = 0;
bool WaitingForExit = false;
bool MaxTradesReached = false;

// Forex-spezifische Variablen
bool TrendBullish = false;
bool HighVolatilityPeriod = false;
double LastATR = 0;
double CurrentVolume = 0;
double AvgVolume = 0;
datetime LastNewsTime = 0;

// Lot-Size Management
double CalculatedLotSize = 0;
double CurrentRiskPercent = 1.0;

// Support/Resistance
double CurrentSupport = 0;
double CurrentResistance = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   Print("🚀 ScalpingEA FOREX EDITION initialisiert - by Alexander Boß");
   Print("💱 Optimiert für Forex-Paare (Juli 2025)");
   
   // PROFESSIONELLES CHART-DESIGN FÜR FOREX-TRADING
   SetupProfessionalChartDesign();
   
   // Initialisierung
   LastBarTime = Time[0];
   
   if(ForexMode)
   {
      Print("💱 Forex-Modus aktiviert - Marktzeiten-optimiert");
      Print("📊 Volatilitäts-Filter: ", VolatilityFilter * 100, "%");
      Print("🎯 Risk-Reward Ratio: ", RiskRewardRatio);
   }
   
   // UNIVERSELLER EA - ALLE SYMBOLE UNTERSTÜTZT
   Print("🌍 UNIVERSELLER EA - Alle Symbole unterstützt!");
   Print("📊 Symbol: ", Symbol(), " | Max Trades/Tag: ", MaxTradesPerDay);
   Print("⚙️ Kundenprofil aktiv: Handelszeiten 15:45-17:45, RRR ", RiskRewardRatio);
   
   // NEWS-FILTER STATUS
   if(NewsFilter)
      Print("📰 News-Filter: AKTIVIERT - Trading pausiert bei wichtigen News");
   else
      Print("📰 News-Filter: DEAKTIVIERT - Trading läuft auch bei News");
   
   // Dashboard erstellen
   if(EnableDashboard)
      CreateForexDashboard();
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                               |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // Dashboard-Objekte entfernen
   ObjectsDeleteAll(0, "Forex_");
   ObjectDelete("ForexDashboard");
   
   Print("🔴 ScalpingEA Forex Edition beendet");
   PrintTradingStats();
}

//+------------------------------------------------------------------+
//| Expert tick function                                            |
//+------------------------------------------------------------------+
void OnTick()
{
   // Dashboard IMMER aktualisieren (auch bei geschlossenem Markt)
   if(EnableDashboard)
   {
      CheckTradeCount(); // Trade-Counter aktualisieren
      CalculatedLotSize = CalculateDynamicLotSize(); // Lot-Size berechnen
      UpdateForexDashboard(); // Dashboard aktualisieren
   }
   
   // Nur bei neuer Kerze weitermachen
   if(Time[0] == LastBarTime)
      return;
   
   LastBarTime = Time[0];
   
   // KUNDENPROFIL-CHECKS
   
   // 1. Symbol-Validierung (alle Symbole erlaubt)
   if(!IsAllowedSymbol())
   {
      return;
   }
   
   // 2. Drawdown Überwachung (nur bei extremen Werten stoppen)
   if(!CheckDrawdownLimit())
      return; // Nur bei wirklich gefährlichem Drawdown stoppen
   
   // 3. Verlust-Serie Management (nur Information)
   HandleLossStreak();
   
   // 4. Forex-spezifische Marktanalyse
   if(!AnalyzeForexMarketConditions())
      return;
   
   // 5. NY Open Boost (Vorteil nutzen, aber nicht beschränken)
   bool isNYOpen = IsNYOpenTime();
   // Keine Beschränkungen mehr - nur Informationen für Dashboard
   
   // Marktanalyse durchführen
   AnalyzeForexMarket();
   
   // Position-Monitoring für Exit-Signale
   if(OrdersTotal() > 0)
      MonitorForexPositions();
   
   // Trading-Logik (nur wenn alle Checks bestanden)
   CheckForexTradingSignals();
}

//+------------------------------------------------------------------+
//| Forex-Marktbedingungen analysieren                             |
//+------------------------------------------------------------------+
bool AnalyzeForexMarketConditions()
{
   // Spread prüfen (in Pips)
   double spread = (Ask - Bid) / Point;
   if(spread > MaxSpread)
   {
      if(EnableAlerts && GetTickCount() % 30000 == 0)
         Print("📊 Spread zu hoch: ", DoubleToStr(spread, 1), " Pips > ", MaxSpread);
      return false;
   }
   
   // Forex-spezifische Volatilitätsprüfung
   double currentATR = iATR(NULL, 0, ATR_Period, 1);
   LastATR = currentATR;
   
   if(currentATR < VolatilityFilter * Close[1])
   {
      if(EnableAlerts && GetTickCount() % 30000 == 0)
         Print("📊 Niedrige Volatilität - ATR: ", DoubleToStr(currentATR, 5));
      return false;
   }
   
   // News-Filter
   if(NewsFilter && IsNewsTime())
   {
      if(EnableAlerts)
         Print("📰 News-Zeit erkannt - Trading pausiert");
      return false;
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| News-Zeit prüfen                                               |
//+------------------------------------------------------------------+
bool IsNewsTime()
{
   datetime currentTime = TimeCurrent();
   int currentHour = TimeHour(currentTime);
   int currentMinute = TimeMinute(currentTime);
   int currentDayOfWeek = TimeDayOfWeek(currentTime);
   
   // FOMC Meeting (Mittwoch 20:00 deutsche Zeit)
   if(currentDayOfWeek == 3 && currentHour == 20 && currentMinute >= 0 && currentMinute <= 120)
   {
      LastNewsTime = currentTime;
      return true;
   }
   
   // CPI Daten (Dienstag/Donnerstag 14:30 deutsche Zeit)
   if((currentDayOfWeek == 2 || currentDayOfWeek == 4) && 
      currentHour == 14 && currentMinute >= 30 && currentMinute <= 90)
   {
      LastNewsTime = currentTime;
      return true;
   }
   
   // NFP (Freitag 14:30 deutsche Zeit)
   if(currentDayOfWeek == 5 && currentHour == 14 && currentMinute >= 30 && currentMinute <= 90)
   {
      LastNewsTime = currentTime;
      return true;
   }
   
   return false;
}

//+------------------------------------------------------------------+
//| Symbol-Validierung - Alle Symbole erlaubt                     |
//+------------------------------------------------------------------+
bool IsAllowedSymbol()
{
   // Alle Symbole sind erlaubt - keine Beschränkungen
   return true;
}

//+------------------------------------------------------------------+
//| Daily Trades Counter (nur Information, keine Beschränkung)    |
//+------------------------------------------------------------------+
void CheckTradeCount()
{
   datetime today = TimeCurrent();
   int currentDay = TimeDay(today);
   int lastTradeDay = TimeDay(LastTradingDay);
   
   // Neuer Tag - Reset Counter
   if(currentDay != lastTradeDay)
   {
      TradesToday = 0;
      MaxTradesReached = false;
      LastTradingDay = today;
   }
   
   // Info-Warnung bei mehr als empfohlenen Trades (keine Blockierung)
   if(TradesToday > MaxTradesPerDay)
   {
      if(EnableAlerts && TradesToday == MaxTradesPerDay + 1)
         Alert("⚠️ INFO: Mehr als ", MaxTradesPerDay, " Trades heute - Trader entscheidet selbst!");
   }
}

//+------------------------------------------------------------------+
//| Drawdown-Limit prüfen                                         |
//+------------------------------------------------------------------+
bool CheckDrawdownLimit()
{
   double currentEquity = AccountEquity();
   double accountBalance = AccountBalance();
   if(accountBalance <= 0) accountBalance = AccountBalance;
   
   CurrentDrawdown = ((accountBalance - currentEquity) / accountBalance) * 100;
   
   if(CurrentDrawdown > MaxDrawdown)
      MaxDrawdown = CurrentDrawdown;
   
   // Nur bei extremem Drawdown stoppen (Sicherheitshalber)
   if(CurrentDrawdown > MaxDrawdownPercent * 2) // Doppelte Grenze
   {
      if(EnableAlerts)
         Alert("🚨 KRITISCHER DRAWDOWN: ", DoubleToStr(CurrentDrawdown, 1), "% - EA gestoppt!");
      return false;
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| Verlust-Serie Management                                       |
//+------------------------------------------------------------------+
void HandleLossStreak()
{
   if(LosingTrades >= 3)
   {
      CurrentRiskPercent = RiskPercent * 0.8; // Risiko reduzieren
      if(EnableAlerts && LosingTrades == 3)
         Print("⚠️ Verlust-Serie: Risiko reduziert auf ", DoubleToStr(CurrentRiskPercent, 1), "%");
   }
   else if(LosingTrades >= 5)
   {
      CurrentRiskPercent = RiskPercent * 0.6; // Stärker reduzieren
      if(EnableAlerts && LosingTrades == 5)
         Print("🚨 Starke Verlust-Serie: Risiko stark reduziert auf ", DoubleToStr(CurrentRiskPercent, 1), "%");
   }
   else
   {
      CurrentRiskPercent = RiskPercent; // Normal
   }
}

//+------------------------------------------------------------------+
//| Dynamische Lot-Size berechnen                                 |
//+------------------------------------------------------------------+
double CalculateDynamicLotSize()
{
   double balance = AccountBalance();
   if(balance <= 0) balance = AccountBalance;
   
   double riskAmount = balance * (CurrentRiskPercent / 100.0);
   double pointValue = MarketInfo(Symbol(), MODE_TICKVALUE);
   
   if(pointValue <= 0) pointValue = 1;
   
   double stopLossPips = SL_Points;
   if(UseATR_SL && LastATR > 0)
   {
      stopLossPips = LastATR / Point / 10; // ATR in Pips
   }
   
   double calculatedLots = riskAmount / (stopLossPips * pointValue * 10);
   
   // Lot-Size Grenzen
   double minLot = MarketInfo(Symbol(), MODE_MINLOT);
   double maxLot = MarketInfo(Symbol(), MODE_MAXLOT);
   double lotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   
   if(calculatedLots < minLot) calculatedLots = minLot;
   if(calculatedLots > maxLot) calculatedLots = maxLot;
   
   // Auf Lot-Step runden
   calculatedLots = MathFloor(calculatedLots / lotStep) * lotStep;
   
   return calculatedLots;
}

//+------------------------------------------------------------------+
//| NY Open Zeit prüfen                                           |
//+------------------------------------------------------------------+
bool IsNYOpenTime()
{
   datetime currentTime = TimeCurrent();
   int currentHour = TimeHour(currentTime);
   int currentMinute = TimeMinute(currentTime);
   
   // NY Open: 9:30 NY = 15:30 deutsche Zeit (Sommer) / 14:30 (Winter)
   // Vereinfacht: 15:30 deutsche Zeit
   if(currentHour == 15 && currentMinute >= 30 && currentMinute <= 45)
      return true;
      
   return false;
}

//+------------------------------------------------------------------+
//| Forex Trading-Zeit prüfen (nur für Dashboard)                 |
//+------------------------------------------------------------------+
bool IsForexTradingTime()
{
   if(!RestrictedTradingHours)
      return true;
   
   datetime currentTime = TimeCurrent();
   int currentHour = TimeHour(currentTime);
   int currentMinute = TimeMinute(currentTime);
   int currentDayOfWeek = TimeDayOfWeek(currentTime);
   
   // Wochenende-Info
   if(SundayTradingOnly && (currentDayOfWeek == 6)) // Samstag
      return false;
   
   // Handelszeiten-Info (15:45-17:45)
   int startTimeMinutes = TradingStartHour * 60 + TradingStartMinute;
   int endTimeMinutes = TradingEndHour * 60 + TradingEndMinute;
   int currentTimeMinutes = currentHour * 60 + currentMinute;
   
   if(currentTimeMinutes >= startTimeMinutes && currentTimeMinutes <= endTimeMinutes)
      return true;
   
   return false;
}

//+------------------------------------------------------------------+
//| Forex-Marktanalyse                                            |
//+------------------------------------------------------------------+
void AnalyzeForexMarket()
{
   // Standard-Analyse mit Forex-Anpassungen
   AnalyzeForexTrendLines();
   AnalyzeForexVolume();
   IdentifyForexSupportResistance();
   CheckForexDivergence();
   CheckForexConfirmationSignals();
   AnalyzeForexMomentum();
}

//+------------------------------------------------------------------+
//| Forex Trend-Linien analysieren                                |
//+------------------------------------------------------------------+
void AnalyzeForexTrendLines()
{
   // Swing Highs und Lows für Forex finden
   double swingHigh = High[iHighest(NULL, 0, MODE_HIGH, SwingPeriod, 1)];
   double swingLow = Low[iLowest(NULL, 0, MODE_LOW, SwingPeriod, 1)];
   
   // Trend bestimmen
   if(Close[1] > swingHigh * 0.999) // Nahe am Swing High
   {
      TrendBullish = true;
   }
   else if(Close[1] < swingLow * 1.001) // Nahe am Swing Low
   {
      TrendBullish = false;
   }
}

//+------------------------------------------------------------------+
//| Forex-Volume analysieren                                      |
//+------------------------------------------------------------------+
void AnalyzeForexVolume()
{
   // Forex hat kein echtes Volume - verwende Tick Volume
   CurrentVolume = (double)Volume[1];
   
   // Volume Durchschnitt
   double volumeSum = 0;
   for(int i = 1; i <= 10; i++) // Kürzerer Zeitraum für Forex
   {
      volumeSum += (double)Volume[i];
   }
   AvgVolume = volumeSum / 10;
   
   // Extreme Volume-Spikes für Forex erkennen
   if(CurrentVolume > AvgVolume * VolumeMultiplier)
   {
      HighVolatilityPeriod = true;
      if(ShowVolatilityZones)
         DrawVolatilityZone();
   }
   else
   {
      HighVolatilityPeriod = false;
   }
}

//+------------------------------------------------------------------+
//| Forex Support/Resistance identifizieren                       |
//+------------------------------------------------------------------+
void IdentifyForexSupportResistance()
{
   // Letzte 50 Kerzen für Forex-S/R analysieren
   int lookback = 50;
   
   // Support finden (niedrigste Tiefs)
   int supportIndex = iLowest(NULL, 0, MODE_LOW, lookback, 1);
   if(supportIndex > 0)
      CurrentSupport = Low[supportIndex];
   
   // Resistance finden (höchste Hochs)
   int resistanceIndex = iHighest(NULL, 0, MODE_HIGH, lookback, 1);
   if(resistanceIndex > 0)
      CurrentResistance = High[resistanceIndex];
}

//+------------------------------------------------------------------+
//| Forex Divergenz prüfen                                        |
//+------------------------------------------------------------------+
void CheckForexDivergence()
{
   double rsi1 = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
   double rsi2 = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 5);
   
   // Bullish Divergenz für Forex
   if(Low[1] < Low[5] && rsi1 > rsi2 && rsi1 < RSI_Oversold + 10)
   {
      if(EnableAlerts && GetTickCount() % 10000 == 0)
         Alert("💱 Starke Bullish Divergenz erkannt!");
   }
   
   // Bearish Divergenz für Forex
   if(High[1] > High[5] && rsi1 < rsi2 && rsi1 > RSI_Overbought - 10)
   {
      if(EnableAlerts && GetTickCount() % 10000 == 0)
         Alert("💱 Starke Bearish Divergenz erkannt!");
   }
}

//+------------------------------------------------------------------+
//| Forex Bestätigungssignale prüfen                              |
//+------------------------------------------------------------------+
void CheckForexConfirmationSignals()
{
   double emaFast = iMA(NULL, 0, EMA_Fast, 0, MODE_EMA, PRICE_CLOSE, 1);
   double emaMedium = iMA(NULL, 0, EMA_Medium, 0, MODE_EMA, PRICE_CLOSE, 1);
   double emaSlow = iMA(NULL, 0, EMA_Slow, 0, MODE_EMA, PRICE_CLOSE, 1);
   
   double macdMain = iMACD(NULL, 0, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE, MODE_MAIN, 1);
   double macdSignal = iMACD(NULL, 0, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE, MODE_SIGNAL, 1);
   
   // Forex Trend-Bestätigung
   bool bullishTrend = (emaFast > emaMedium && emaMedium > emaSlow && macdMain > macdSignal);
   bool bearishTrend = (emaFast < emaMedium && emaMedium < emaSlow && macdMain < macdSignal);
   
   if(bullishTrend)
   {
      TrendBullish = true;
   }
   else if(bearishTrend)
   {
      TrendBullish = false;
   }
}

//+------------------------------------------------------------------+
//| Forex Momentum analysieren                                    |
//+------------------------------------------------------------------+
void AnalyzeForexMomentum()
{
   double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
   double atr = iATR(NULL, 0, ATR_Period, 1);
   
   // Forex-spezifische Momentum-Bewertung
   bool strongMomentum = (atr > VolatilityFilter * Close[1]) && 
                        ((rsi > 50 && TrendBullish) || (rsi < 50 && !TrendBullish));
   
   if(strongMomentum && EnableAlerts && GetTickCount() % 20000 == 0)
   {
      Print("💱 Starkes Forex-Momentum erkannt - ATR: ", DoubleToStr(atr, 5));
   }
}

//+------------------------------------------------------------------+
//| Forex Trading-Signale prüfen                                  |
//+------------------------------------------------------------------+
void CheckForexTradingSignals()
{
   if(OrdersTotal() >= 1) // Nur 1 Position gleichzeitig
      return;
   
   double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
   double emaFast = iMA(NULL, 0, EMA_Fast, 0, MODE_EMA, PRICE_CLOSE, 1);
   double emaSlow = iMA(NULL, 0, EMA_Slow, 0, MODE_EMA, PRICE_CLOSE, 1);
   
   // Forex BUY Signal
   if(TrendBullish && Close[1] > emaFast && emaFast > emaSlow && 
      rsi > 50 && rsi < RSI_Overbought && HighVolatilityPeriod)
   {
      if(OpenForexTrade(OP_BUY))
      {
         if(ShowEntryArrows)
            DrawForexEntryArrow("ForexBuy_" + TimeToStr(Time[0]), Time[0],
                               Low[0] - 20*Point, 233, clrLime, "🚀 BUY");
      }
   }
   
   // Forex SELL Signal
   if(!TrendBullish && Close[1] < emaFast && emaFast < emaSlow && 
      rsi < 50 && rsi > RSI_Oversold && HighVolatilityPeriod)
   {
      if(OpenForexTrade(OP_SELL))
      {
         if(ShowEntryArrows)
            DrawForexEntryArrow("ForexSell_" + TimeToStr(Time[0]), Time[0],
                               High[0] + 20*Point, 234, clrRed, "⚠️ SELL");
      }
   }
}

//+------------------------------------------------------------------+
//| Forex Trade öffnen                                            |
//+------------------------------------------------------------------+
bool OpenForexTrade(int orderType)
{
   double lotSize = CalculatedLotSize;
   if(lotSize <= 0) lotSize = LotSize;
   
   double price, sl, tp;
   string comment = "Forex_EA_v2.25";
   
   // NY Open Boost
   if(NYOpenFocus && IsNYOpenTime())
   {
      lotSize *= 1.2; // 20% größere Position bei NY Open
      comment += "_NYOpen";
   }
   
   if(orderType == OP_BUY)
   {
      price = Ask;
      
      if(UseATR_SL && LastATR > 0)
         sl = price - (LastATR * ATR_Multiplier);
      else
         sl = price - (SL_Points * Point * 10); // Pips zu Points
      
      // Höhere Take-Profits für Kundenprofil
      tp = price + (TP_Points * Point * 10 * RiskRewardRatio);
      
      // NY Open: Erweiterte TPs
      if(NYOpenFocus && IsNYOpenTime())
         tp = price + (TP2_Points * Point * 10 * RiskRewardRatio);
   }
   else // OP_SELL
   {
      price = Bid;
      
      if(UseATR_SL && LastATR > 0)
         sl = price + (LastATR * ATR_Multiplier);
      else
         sl = price + (SL_Points * Point * 10);
      
      tp = price - (TP_Points * Point * 10 * RiskRewardRatio);
      
      if(NYOpenFocus && IsNYOpenTime())
         tp = price - (TP2_Points * Point * 10 * RiskRewardRatio);
   }
   
   int ticket = OrderSend(Symbol(), orderType, lotSize, price, Slippage, sl, tp, comment, MagicNumber, 0, clrNONE);
   
   if(ticket > 0)
   {
      TradesToday++;
      TotalTrades++;
      LastTradeTime = TimeCurrent();
      
      if(EnableSounds)
         PlaySound(SoundFileEntry);
      
      if(EnableAlerts)
         Alert("💱 Forex Trade geöffnet: ", (orderType == OP_BUY ? "BUY" : "SELL"), 
               " | Lots: ", DoubleToStr(lotSize, 3), " | Symbol: ", Symbol());
      
      return true;
   }
   else
   {
      int error = GetLastError();
      Print("🔴 Forex-Trade Fehler: ", error, " - ", ErrorDescription(error));
      return false;
   }
}

//+------------------------------------------------------------------+
//| Forex Positionen überwachen                                   |
//+------------------------------------------------------------------+
void MonitorForexPositions()
{
   for(int i = OrdersTotal() - 1; i >= 0; i--)
   {
      if(!OrderSelect(i, SELECT_BY_POS))
         continue;
      
      if(OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber)
         continue;
      
      double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
      bool shouldExit = false;
      string exitReason = "";
      
      // Exit-Bedingungen für Forex
      if(OrderType() == OP_BUY)
      {
         // RSI Überkauft
         if(rsi > RSI_Overbought)
         {
            shouldExit = true;
            exitReason = "RSI Überkauft";
         }
         // Bearish Setup
         else if(!TrendBullish)
         {
            shouldExit = true;
            exitReason = "Bearish Setup";
         }
      }
      else if(OrderType() == OP_SELL)
      {
         // RSI Überverkauft
         if(rsi < RSI_Oversold)
         {
            shouldExit = true;
            exitReason = "RSI Überverkauft";
         }
         // Bullish Setup
         else if(TrendBullish)
         {
            shouldExit = true;
            exitReason = "Bullish Setup";
         }
      }
      
      if(shouldExit)
      {
         double closePrice = (OrderType() == OP_BUY) ? Bid : Ask;
         
         if(OrderClose(OrderTicket(), OrderLots(), closePrice, Slippage, clrNONE))
         {
            double profit = OrderProfit() + OrderSwap() + OrderCommission();
            bool isWin = profit > 0;
            
            if(isWin)
               WinningTrades++;
            else
               LosingTrades++;
            
            TotalProfit += profit;
            
            if(EnableSounds)
               PlaySound(isWin ? SoundFileWin : SoundFileLoss);
            
            if(EnableAlerts)
               Alert("💱 Forex Position geschlossen: ", exitReason, 
                     " | Profit: ", DoubleToStr(profit, 2));
            
            if(ShowExitArrows)
            {
               int arrowCode = (OrderType() == OP_BUY) ? 242 : 241;
               DrawForexExitArrow("ForexExit_" + TimeToStr(Time[0]), Time[0],
                                 (OrderType() == OP_BUY) ? High[0] + 15*Point : Low[0] - 15*Point,
                                 arrowCode, clrYellow);
            }
            
            if(ShowSuccessSymbols)
            {
               DrawForexSuccessSymbol("ForexResult_" + TimeToStr(Time[0]), Time[0], Close[0], isWin, profit);
            }
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Error Description                                              |
//+------------------------------------------------------------------+
string ErrorDescription(int errorCode)
{
   switch(errorCode)
   {
      case 0: return "Kein Fehler";
      case 1: return "Kein Fehler, aber Ergebnis unbekannt";
      case 2: return "Allgemeiner Fehler";
      case 3: return "Ungültige Parameter";
      case 4: return "Trade Server beschäftigt";
      case 130: return "Ungültige Stops";
      case 131: return "Ungültiges Trade-Volumen";
      case 132: return "Markt ist geschlossen";
      case 133: return "Trading ist deaktiviert";
      case 134: return "Nicht genügend Geld";
      case 135: return "Preis hat sich geändert";
      default: return "Unbekannter Fehler (" + IntegerToString(errorCode) + ")";
   }
}

//+------------------------------------------------------------------+
//| Forex Dashboard erstellen                                     |
//+------------------------------------------------------------------+
void CreateForexDashboard()
{
   // Dashboard-Hintergrund
   ObjectCreate("ForexDashboard", OBJ_RECTANGLE_LABEL, 0, 0, 0);
   ObjectSet("ForexDashboard", OBJPROP_CORNER, 0);
   ObjectSet("ForexDashboard", OBJPROP_XDISTANCE, DashboardX);
   ObjectSet("ForexDashboard", OBJPROP_YDISTANCE, DashboardY);
   ObjectSet("ForexDashboard", OBJPROP_XSIZE, 380);
   ObjectSet("ForexDashboard", OBJPROP_YSIZE, 400);
   ObjectSet("ForexDashboard", OBJPROP_BGCOLOR, clrDarkSlateGray);
   ObjectSet("ForexDashboard", OBJPROP_BORDER_COLOR, clrGold);
   ObjectSet("ForexDashboard", OBJPROP_BORDER_TYPE, BORDER_FLAT);
   
   // Labels - Standard
   CreateForexLabel("Forex_Title", "💱 SCALPING EA - FOREX", DashboardX + 10, DashboardY + 10, clrGold, 11);
   CreateForexLabel("Forex_Symbol", "", DashboardX + 10, DashboardY + 30, clrWhite, 10);
   CreateForexLabel("Forex_Trend", "", DashboardX + 10, DashboardY + 50, clrWhite, 10);
   CreateForexLabel("Forex_Setup", "", DashboardX + 10, DashboardY + 70, clrWhite, 10);
   CreateForexLabel("Forex_Volume", "", DashboardX + 10, DashboardY + 90, clrWhite, 10);
   CreateForexLabel("Forex_Position", "", DashboardX + 10, DashboardY + 110, clrWhite, 10);
   CreateForexLabel("Forex_Support", "", DashboardX + 10, DashboardY + 130, clrWhite, 10);
   CreateForexLabel("Forex_Resistance", "", DashboardX + 10, DashboardY + 150, clrWhite, 10);
   
   // KUNDENPROFIL-LABELS
   CreateForexLabel("Forex_DailyTrades", "", DashboardX + 10, DashboardY + 180, clrWhite, 10);
   CreateForexLabel("Forex_Risk", "", DashboardX + 10, DashboardY + 200, clrWhite, 10);
   CreateForexLabel("Forex_Drawdown", "", DashboardX + 10, DashboardY + 220, clrWhite, 10);
   CreateForexLabel("Forex_TradingTime", "", DashboardX + 10, DashboardY + 240, clrWhite, 10);
   CreateForexLabel("Forex_CurrentSymbol", "", DashboardX + 10, DashboardY + 260, clrWhite, 10);
   CreateForexLabel("Forex_NewsFilter", "", DashboardX + 10, DashboardY + 280, clrWhite, 10);
   
   // Status & Statistiken
   CreateForexLabel("Forex_Status", "", DashboardX + 10, DashboardY + 300, clrWhite, 10);
   CreateForexLabel("Forex_Stats", "", DashboardX + 10, DashboardY + 320, clrWhite, 10);
   CreateForexLabel("Forex_Profit", "", DashboardX + 10, DashboardY + 340, clrWhite, 10);
   CreateForexLabel("Forex_WinRate", "", DashboardX + 10, DashboardY + 360, clrWhite, 10);
}

//+------------------------------------------------------------------+
//| Forex Label erstellen                                         |
//+------------------------------------------------------------------+
void CreateForexLabel(string name, string text, int x, int y, color clr, int fontSize)
{
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name, OBJPROP_CORNER, 0);
   ObjectSet(name, OBJPROP_XDISTANCE, x);
   ObjectSet(name, OBJPROP_YDISTANCE, y);
   ObjectSetText(name, text, fontSize, "Arial", clr);
}

//+------------------------------------------------------------------+
//| Forex Dashboard aktualisieren                                 |
//+------------------------------------------------------------------+
void UpdateForexDashboard()
{
   // Symbol Info
   double spread = (Ask - Bid) / Point;
   ObjectSetText("Forex_Symbol", "📊 " + Symbol() + " | Spread: " + DoubleToStr(spread, 1) + " Pips", 10, "Arial", clrWhite);
   
   // Trend-Richtung
   string trendText = TrendBullish ? "📈 BULLISH" : "📉 BEARISH";
   color trendColor = TrendBullish ? clrLime : clrRed;
   ObjectSetText("Forex_Trend", "Trend: " + trendText, 10, "Arial", trendColor);
   
   // Setup-Status
   string setupStatus = "⏳ WAITING FOR SIGNAL";
   color setupColor = clrGray;
   
   if(TrendBullish && HighVolatilityPeriod)
   {
      setupStatus = "🚀 BULLISH SETUP";
      setupColor = clrLime;
   }
   else if(!TrendBullish && HighVolatilityPeriod)
   {
      setupStatus = "⚠️ BEARISH SETUP";
      setupColor = clrRed;
   }
   
   ObjectSetText("Forex_Setup", setupStatus, 10, "Arial", setupColor);
   
   // Volume-Status
   string volumeStatus = HighVolatilityPeriod ? "🔥 HIGH VOLATILITY" : "😴 LOW VOLATILITY";
   color volumeColor = HighVolatilityPeriod ? clrOrange : clrGray;
   ObjectSetText("Forex_Volume", volumeStatus, 10, "Arial", volumeColor);
   
   // Position-Status
   string positionText = "💼 Positionen: " + IntegerToString(OrdersTotal());
   if(OrdersTotal() > 0)
   {
      positionText += " | 🔄 MONITORING";
   }
   ObjectSetText("Forex_Position", positionText, 10, "Arial", clrAqua);
   
   // Support/Resistance (vereinfacht)
   ObjectSetText("Forex_Support", "🔵 Support: " + DoubleToStr(CurrentSupport, 5), 10, "Arial", clrAqua);
   ObjectSetText("Forex_Resistance", "🔴 Resistance: " + DoubleToStr(CurrentResistance, 5), 10, "Arial", clrOrange);
   
   // Statistiken
   string statsText = "📊 Trades: " + IntegerToString(TotalTrades) + " | 🏆 Wins: " + IntegerToString(WinningTrades) + " | 📉 Loss: " + IntegerToString(LosingTrades);
   ObjectSetText("Forex_Stats", statsText, 10, "Arial", clrWhite);
   
   string profitText = "💰 Profit: " + DoubleToStr(TotalProfit, 2) + " " + AccountCurrency();
   color profitColor = (TotalProfit >= 0) ? clrLime : clrRed;
   ObjectSetText("Forex_Profit", profitText, 10, "Arial", profitColor);
   
   double winRate = 0;
   if(TotalTrades > 0)
      winRate = (WinningTrades * 100.0) / TotalTrades;
   string winRateText = "🎯 Win-Rate: " + DoubleToStr(winRate, 1) + "%";
   color winRateColor = (winRate >= 70) ? clrLime : (winRate >= 50) ? clrYellow : clrRed;
   ObjectSetText("Forex_WinRate", winRateText, 10, "Arial", winRateColor);
   
   // KUNDENPROFIL-DASHBOARD ERWEITERUNGEN
   
   // Trades pro Tag (Info ohne Beschränkung)
   string tradeCountText = "📅 Heute: " + IntegerToString(TradesToday) + " Trades (Empfehlung: " + IntegerToString(MaxTradesPerDay) + ")";
   color tradeCountColor;
   if(TradesToday > MaxTradesPerDay)
      tradeCountColor = clrOrange; // Warnung aber kein Stopp
   else if(TradesToday >= MaxTradesPerDay)
      tradeCountColor = clrYellow; // Am Limit
   else
      tradeCountColor = clrLime; // Unter Empfehlung
   ObjectSetText("Forex_DailyTrades", tradeCountText, 10, "Arial", tradeCountColor);
   
   // Aktuelles Risiko
   string riskText = "⚖️ Risiko: " + DoubleToStr(CurrentRiskPercent, 1) + "% (" + DoubleToStr(CalculatedLotSize, 3) + " Lots)";
   color riskColor = (CurrentRiskPercent < RiskPercent) ? clrYellow : clrWhite;
   ObjectSetText("Forex_Risk", riskText, 10, "Arial", riskColor);
   
   // Drawdown Status
   string ddText = "📉 Drawdown: " + DoubleToStr(CurrentDrawdown, 1) + "% (Max: " + DoubleToStr(MaxDrawdownPercent, 1) + "%)";
   color ddColor = (CurrentDrawdown > MaxDrawdownPercent * 0.8) ? clrRed : (CurrentDrawdown > MaxDrawdownPercent * 0.6) ? clrYellow : clrLime;
   ObjectSetText("Forex_Drawdown", ddText, 10, "Arial", ddColor);
   
   // Trading-Zeit Status (Info ohne Beschränkung)
   string timeStatus = "";
   color timeColor;
   if(IsForexTradingTime())
   {
      if(IsNYOpenTime())
      {
         timeStatus = "🇺🇸 NY OPEN - OPTIMAL";
         timeColor = clrAqua;
      }
      else
      {
         timeStatus = "✅ EMPFOHLENE ZEIT";
         timeColor = clrLime;
      }
   }
   else
   {
      timeStatus = "ℹ️ AUSSERHALB EMPF. ZEIT";
      timeColor = clrYellow; // Warnung statt Grau
   }
   ObjectSetText("Forex_TradingTime", timeStatus, 10, "Arial", timeColor);
   
   // Aktuelles Symbol anzeigen
   string currentSymbolText = "💱 Symbol: " + Symbol();
   ObjectSetText("Forex_CurrentSymbol", currentSymbolText, 10, "Arial", clrAqua);
   
   // News-Filter Status anzeigen
   string newsFilterText = "📰 News-Filter: ";
   color newsFilterColor;
   if(NewsFilter)
   {
      newsFilterText += "AKTIVIERT";
      newsFilterColor = clrYellow;
      if(IsNewsTime())
      {
         newsFilterText += " (AKTIV)";
         newsFilterColor = clrRed;
      }
   }
   else
   {
      newsFilterText += "DEAKTIVIERT";
      newsFilterColor = clrGray;
   }
   ObjectSetText("Forex_NewsFilter", newsFilterText, 10, "Arial", newsFilterColor);
}

//+------------------------------------------------------------------+
//| Trading-Statistiken drucken                                   |
//+------------------------------------------------------------------+
void PrintTradingStats()
{
   Print("=== FOREX TRADING STATISTIKEN ===");
   Print("📊 Gesamt Trades: ", TotalTrades);
   Print("🏆 Gewinn-Trades: ", WinningTrades);
   Print("📉 Verlust-Trades: ", LosingTrades);
   Print("💰 Gesamt-Profit: ", DoubleToStr(TotalProfit, 2));
   
   if(TotalTrades > 0)
   {
      double winRate = (WinningTrades * 100.0) / TotalTrades;
      Print("🎯 Win-Rate: ", DoubleToStr(winRate, 1), "%");
   }
   
   Print("📉 Max. Drawdown: ", DoubleToStr(MaxDrawdown, 1), "%");
   Print("📅 Trades heute: ", TradesToday);
   Print("============================");
}

//+------------------------------------------------------------------+
//| Professionelles Chart-Design Setup                             |
//+------------------------------------------------------------------+
void SetupProfessionalChartDesign()
{
   Print("🎨 Lade professionelles Forex-Chart Design...");
   
   // === HINTERGRUND & GRID ===
   ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrBlack);              // Schwarzer Hintergrund
   ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrWhite);              // Weißer Text
   ChartSetInteger(0, CHART_COLOR_GRID, clrDarkGray);                 // Dunkles Grid
   ChartSetInteger(0, CHART_SHOW_GRID, true);                         // Grid aktivieren
   
   // === FOREX-OPTIMIERTE KERZEN-FARBEN ===
   ChartSetInteger(0, CHART_COLOR_CHART_UP, clrLime);                 // Lime für Bullish
   ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrDeepPink);           // Pink für Bearish
   ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrGreen);             // Grün für Bull Körper
   ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrCrimson);           // Crimson für Bear Körper
   
   // === CHART-STIL ===
   ChartSetInteger(0, CHART_MODE, CHART_CANDLES);                      // Kerzen-Modus
   ChartSetInteger(0, CHART_SHIFT, true);                              // Chart-Verschiebung
   ChartSetInteger(0, CHART_AUTOSCROLL, true);                         // Auto-Scroll
   
   // === VOLUME & INDIKATOREN ===
   ChartSetInteger(0, CHART_SHOW_VOLUMES, true);                       // Volume anzeigen
   ChartSetInteger(0, CHART_COLOR_VOLUME, clrDarkGray);                // Graue Volumes
   
   // === ASK/BID LINIEN ===
   ChartSetInteger(0, CHART_SHOW_ASK_LINE, true);                      // Ask-Linie
   ChartSetInteger(0, CHART_COLOR_ASK, clrHotPink);                    // Hot Pink für Ask
   ChartSetInteger(0, CHART_SHOW_BID_LINE, true);                      // Bid-Linie  
   ChartSetInteger(0, CHART_COLOR_BID, clrDeepSkyBlue);                // Deep Sky Blue für Bid
   
   // === TRADE-LEVELS ===
   ChartSetInteger(0, CHART_SHOW_TRADE_LEVELS, true);                  // Trade-Level anzeigen
   ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, clrOrangeRed);           // Orange-Red für SL
   
   Print("✅ Professionelles Forex-Design geladen!");
   Print("💱 Bullish Kerzen: Neon-Grün | Bearish Kerzen: Pink");
   Print("🎯 Ask: Hot Pink | Bid: Deep Sky Blue");
}

//+------------------------------------------------------------------+
//| Volatilitäts-Zone zeichnen                                    |
//+------------------------------------------------------------------+
void DrawVolatilityZone()
{
   string zoneName = "VolZone_" + TimeToStr(Time[1]);
   ObjectCreate(zoneName, OBJ_RECTANGLE, 0, Time[2], High[1] + 10*Point, Time[0], Low[1] - 10*Point);
   ObjectSet(zoneName, OBJPROP_COLOR, clrDarkOrange);
   ObjectSet(zoneName, OBJPROP_STYLE, STYLE_DOT);
   ObjectSet(zoneName, OBJPROP_BACK, true);
}

//+------------------------------------------------------------------+
//| Forex Entry Arrow zeichnen                                    |
//+------------------------------------------------------------------+
void DrawForexEntryArrow(string name, datetime time, double price, int arrowCode, color clr, string direction)
{
   ObjectCreate(name, OBJ_ARROW, 0, time, price);
   ObjectSet(name, OBJPROP_ARROWCODE, arrowCode);
   ObjectSet(name, OBJPROP_COLOR, clr);
   ObjectSet(name, OBJPROP_WIDTH, 3);
   
   // Text hinzufügen
   ObjectCreate(name + "_text", OBJ_TEXT, 0, time, price);
   ObjectSetText(name + "_text", direction, 10, "Arial", clr);
}

//+------------------------------------------------------------------+
//| Forex Exit Arrow zeichnen                                     |
//+------------------------------------------------------------------+
void DrawForexExitArrow(string name, datetime time, double price, int arrowCode, color clr)
{
   ObjectCreate(name, OBJ_ARROW, 0, time, price);
   ObjectSet(name, OBJPROP_ARROWCODE, arrowCode);
   ObjectSet(name, OBJPROP_COLOR, clr);
   ObjectSet(name, OBJPROP_WIDTH, 2);
}

//+------------------------------------------------------------------+
//| Forex Success Symbol zeichnen                                 |
//+------------------------------------------------------------------+
void DrawForexSuccessSymbol(string name, datetime time, double price, bool isWin, double profit)
{
   int symbolCode = isWin ? 252 : 251; // Häkchen oder X
   color symbolColor = isWin ? clrLime : clrRed;
   
   ObjectCreate(name, OBJ_ARROW, 0, time, price);
   ObjectSet(name, OBJPROP_ARROWCODE, symbolCode);
   ObjectSet(name, OBJPROP_COLOR, symbolColor);
   ObjectSet(name, OBJPROP_WIDTH, 3);
   
   // Profit-Text
   string profitText = DoubleToStr(profit, 2);
   ObjectCreate(name + "_profit", OBJ_TEXT, 0, time, price);
   ObjectSetText(name + "_profit", profitText, 8, "Arial", symbolColor);
}