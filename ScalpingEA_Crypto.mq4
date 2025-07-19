//+------------------------------------------------------------------+
//| ScalpingEA_Crypto.mq4                                           |
//| Crypto Expert Advisor - Kundenprofil-optimiert                 |
//| Copyright 2025, Alexander Boß                                   |
//| https://www.b0ss.dev                                            |
//+------------------------------------------------------------------+
//| CRYPTO EDITION - Optimiert für BTCUSD, ETHUSDT, SOLUSDT, etc. |
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
extern double LotSize = 0.01;                   // Start-Lot (Standard für 1:50-75 Hebel)
extern double RiskPercent = 1.0;                // Risiko pro Trade in %
extern double AccountBalance = 1000.0;          // Referenz-Kontostand (professionell)
extern int MagicNumber = 12345;                  // Magic Number
extern double RiskRewardRatio = 2.5;            // Risk-Reward Verhältnis (höhere Gewinne)
extern int MaxTradesPerDay = 3;                 // Max Trades pro Tag (Empfehlung)
extern double MaxDrawdownPercent = 2.0;         // Max. Drawdown in %
extern bool EnableAlerts = true;                // Popup-Alerts aktivieren
extern bool EnableSounds = true;                // Sound-Alerts aktivieren
extern bool EnableDashboard = true;             // Dashboard anzeigen

// === KRYPTO-MARKT EINSTELLUNGEN ===
extern bool CryptoMode = true;                   // Krypto-Modus aktiviert
extern bool Trade24Hours = false;                // Begrenzte Handelszeiten
extern bool RestrictedTradingHours = true;     // Trading-Zeit Info anzeigen
extern bool NYOpenFocus = true;                 // NY Open Focus (15:30 deutsche Zeit)
extern bool SundayTradingOnly = true;           // Wochenende Info
extern bool NewsFilter = false;                 // News-Filter (Kunde kann ein/ausschalten)
extern double MinSpread = 0.0001;               // Min. Spread für Trading
extern double MaxSpread = 0.005;                // Max. Spread für Trading

// === UNIVERSELLE SYMBOL-UNTERSTÜTZUNG ===
// Alle Symbole sind standardmäßig erlaubt - keine Beschränkungen

// === VOLATILITÄTS-MANAGEMENT ===
extern bool UseATR_SL = true;                    // ATR für SL (WICHTIG für Krypto)
extern double ATR_Multiplier = 3.0;              // Höher für Krypto-Spikes
extern int ATR_Period = 21;                      // Stabilere ATR
extern double VolatilityFilter = 0.02;           // 2% Volatilitäts-Filter

// === TECHNISCHE INDIKATOREN - KRYPTO OPTIMIERT ===
extern int EMA_Fast = 8;                         // Schneller für Krypto-Momentum
extern int EMA_Medium = 18;                      // Krypto-Zyklen angepasst
extern int EMA_Slow = 42;                        // Längerfristige Tendenz

extern int RSI_Period = 12;                      // Reaktiver für schnelle Märkte
extern double RSI_Overbought = 75;               // Krypto kann länger überkauft bleiben
extern double RSI_Oversold = 25;                 // Starke Korrekturen möglich

extern int MACD_Fast = 10;                       // Schneller für Krypto-Trends
extern int MACD_Slow = 21;                       // Kürzere Zyklen
extern int MACD_Signal = 7;                      // Reaktiver

// === VOLUME-ANALYSE FÜR KRYPTO ===
extern double VolumeMultiplier = 2.5;            // Extreme Volume-Spikes
extern int VolumePeriod = 14;                    // Kürzere Periode
extern bool VolumeConfirmation = true;           // Volume-Bestätigung

// === SWING-ANALYSE ===
extern int SwingPeriod = 15;                     // Kürzere Swings
extern double BreakoutThreshold = 0.002;         // 0.2% für Krypto-Breakouts
extern int TrendLinePeriod = 34;                 // Fibonacci-basiert

// === SUPPORT/RESISTANCE ===
extern int SR_Lookback = 200;                    // Längere Historie
extern double SR_Strength = 2;                   // Weniger Touches nötig
extern bool DynamicSR = true;                    // Dynamische SR-Zonen

// === STOP LOSS & TAKE PROFIT - OPTIMIERT FÜR HÖHERE GEWINNE ===
extern double SL_Points = 400;                   // Angepasst für besseres RRR
extern double TP_Points = 1000;                  // Höhere TPs für bessere Gewinne
extern double TP2_Points = 1500;                 // Zweites TP-Level
extern bool TrailingSL = true;                   // Trailing Stop aktivieren
extern double TrailingDistance = 250;            // Engerer Trailing-Abstand

// === TRADING SESSIONS (UTC+2) - KUNDENPROFIL ANGEPASST ===
extern bool SessionFilter = true;                // Session-Filter aktiviert
extern int TradingStartHour = 15;                // 15:45 deutsche Zeit
extern int TradingStartMinute = 45;              //
extern int TradingEndHour = 17;                  // 17:45 deutsche Zeit
extern int TradingEndMinute = 45;                //
extern int NYOpenHour = 15;                      // 15:30 deutsche Zeit (9:30 NY)
extern int NYOpenMinute = 30;                    //
extern bool NYOpenBoost = true;                  // Verstärkte Aktivität um NY Open

// === NEWS & EVENT FILTER ===
extern bool AvoidFOMC = true;                    // Fed-Meetings meiden
extern bool AvoidCPI = true;                     // Inflationsdaten meiden
extern bool WeekendTrading = false;              // Nur Sonntag-Trading

// === KRYPTO-SPEZIFISCHE FEATURES ===
extern bool CorrelationFilter = true;            // BTC-Korrelation prüfen
extern double MaxCorrelation = 0.8;              // Max. Korrelation zu BTC
extern bool OnChainAnalysis = false;             // On-Chain Daten (experimentell)
extern bool SocialSentiment = false;             // Social Sentiment (experimentell)

// === VISUAL & AUDIO SETTINGS ===
extern bool ShowEntryArrows = true;              // Entry-Pfeile anzeigen
extern bool ShowExitArrows = true;               // Exit-Pfeile anzeigen
extern bool ShowSuccessSymbols = true;           // Erfolgs-Symbole anzeigen
extern bool ShowVolatilityZones = true;          // Volatilitäts-Zonen
extern string SoundFileEntry = "alert.wav";      // Sound für Entry
extern string SoundFileExit = "alert2.wav";     // Sound für Exit
extern string SoundFileWin = "ok.wav";          // Sound für Gewinn
extern string SoundFileLoss = "timeout.wav";    // Sound für Verlust
extern int ArrowSize = 4;                        // Größere Pfeile für Krypto

//+------------------------------------------------------------------+
//| Globale Variablen                                               |
//+------------------------------------------------------------------+

datetime LastBarTime = 0;
double LastSupport = 0;
double LastResistance = 0;
string TrendDirection = "RANGING";
bool BullishSetup = false;
bool BearishSetup = false;
double CurrentVolume = 0;
double AvgVolume = 0;
double CurrentVolatility = 0;
double CurrentSpread = 0;

// Dashboard Variablen
int DashboardX = 20;
int DashboardY = 30;

// Trading Tracking - Erweitert für Kundenprofil
int TotalTrades = 0;
int TradesToday = 0;
int WinningTrades = 0;
int LosingTrades = 0;
double TotalProfit = 0;
double CurrentDrawdown = 0;
double MaxDrawdown = 0;
datetime LastTradeTime = 0;
datetime LastTradingDay = 0;
bool WaitingForExit = false;
bool MaxTradesReached = false;

// Krypto-spezifische Variablen
bool BTCBullish = false;
bool HighVolatilityPeriod = false;
double LastATR = 0;
datetime LastNewsTime = 0;

// Lot-Size Management
double CalculatedLotSize = 0;
double CurrentRiskPercent = 1.0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   Print("ScalpingEA CRYPTO EDITION initialisiert - by Alexander Boss");
   Print("Optimiert für Krypto-Paare (Juli 2025)");
   
   // PROFESSIONELLES CHART-DESIGN FÜR KRYPTO-TRADING
   SetupProfessionalChartDesign();
   
   // Initialisierung
   LastBarTime = Time[0];
   
   if(CryptoMode)
   {
      Print("Krypto-Modus aktiviert - 24/7 Trading bereit");
      Print("Volatilitaets-Filter: ", VolatilityFilter * 100, "%");
      Print("Risk-Reward Ratio: ", RiskRewardRatio);
   }
   
   // UNIVERSELLER EA - ALLE SYMBOLE UNTERSTÜTZT
   Print("UNIVERSELLER EA - Alle Symbole unterstuetzt!");
   Print("Symbol: ", Symbol(), " | Max Trades/Tag: ", MaxTradesPerDay);
   Print("Kundenprofil aktiv: Handelszeiten 15:45-17:45, RRR ", RiskRewardRatio);
   
   // NEWS-FILTER STATUS
   if(NewsFilter)
      Print("News-Filter: AKTIVIERT - Trading pausiert bei wichtigen News");
   else
      Print("News-Filter: DEAKTIVIERT - Trading laeuft auch bei News");
   
   // Dashboard erstellen UND sofort aktualisieren
   if(EnableDashboard)
   {
       CreateCryptoDashboard();
       UpdateCryptoDashboard(); // Sofortige Aktualisierung hinzufügen
   }
   
   // Timer für Dashboard-Updates bei geschlossenem Markt
   EventSetTimer(10); // Alle 10 Sekunden aktualisieren
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                               |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    // Timer stoppen
    EventKillTimer();
    
    // Alle Objekte löschen
    ObjectsDeleteAll(0, OBJ_TREND);
    ObjectsDeleteAll(0, OBJ_HLINE);
    ObjectsDeleteAll(0, OBJ_ARROW);
    ObjectsDeleteAll(0, OBJ_LABEL);
   ObjectsDeleteAll(0, OBJ_RECTANGLE);
   
   Print("ScalpingEA Crypto Edition beendet");
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
      UpdateCryptoDashboard(); // Dashboard aktualisieren
   }
   
   // Nur bei neuer Kerze weitermachen
   if(Time[0] == LastBarTime)
      return;
   
   LastBarTime = Time[0];
   
   // KUNDENPROFIL-CHECKS
   
   // 1. Symbol-Validierung für erlaubte Krypto-Paare
   if(!IsAllowedSymbol())
   {
      if(EnableAlerts && GetTickCount() % 60000 == 0) // Alle 60 Sekunden
         Print("Symbol ", Symbol(), " nicht in erlaubten Paaren");
      return;
   }
   
   // 2. Drawdown Überwachung (nur bei extremen Werten stoppen)
   if(!CheckDrawdownLimit())
      return; // Nur bei wirklich gefährlichem Drawdown stoppen
   
   // 3. Verlust-Serie Management (nur Information)
   HandleLossStreak();
   
   // 4. Krypto-spezifische Marktanalyse
   if(!AnalyzeCryptoMarketConditions())
      return;
   
   // 5. NY Open Boost (Vorteil nutzen, aber nicht beschränken)
   bool isNYOpen = IsNYOpenTime();
   // Keine Beschränkungen mehr - nur Informationen für Dashboard
   
   // Marktanalyse durchführen
   AnalyzeCryptoMarket();
   
   // Position-Monitoring für Exit-Signale
   if(OrdersTotal() > 0)
      MonitorCryptoPositions();
   
   // Trading-Logik (nur wenn alle Checks bestanden)
   CheckCryptoTradingSignals();
}

//+------------------------------------------------------------------+
//| Krypto-Marktbedingungen analysieren                            |
//+------------------------------------------------------------------+
bool AnalyzeCryptoMarketConditions()
{
   // Spread prüfen
   CurrentSpread = (Ask - Bid) / Ask;
   if(CurrentSpread < MinSpread || CurrentSpread > MaxSpread)
   {
      if(EnableAlerts && GetTickCount() % 30000 == 0) // Alle 30 Sekunden
         Print("Spread ausserhalb der Grenzen: ", CurrentSpread * 100, "%");
      return false;
   }
   
   // Volatilität berechnen
   CurrentVolatility = CalculateVolatility();
   HighVolatilityPeriod = (CurrentVolatility > VolatilityFilter);
   
   // ATR aktualisieren
   LastATR = iATR(NULL, 0, ATR_Period, 1);
   
   // News-Filter
   if(NewsFilter && IsNewsTime())
   {
      Print("News-Zeit erkannt - Trading pausiert");
      return false;
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| Volatilität berechnen                                          |
//+------------------------------------------------------------------+
double CalculateVolatility()
{
   double sum = 0;
   int period = 20;
   
   for(int i = 1; i <= period; i++)
   {
      double change = MathAbs((Close[i] - Close[i+1]) / Close[i+1]);
      sum += change;
   }
   
   return sum / period;
}

//+------------------------------------------------------------------+
//| News-Zeit prüfen                                               |
//+------------------------------------------------------------------+
bool IsNewsTime()
{
   int hour = TimeHour(TimeCurrent());
   int dow = TimeDayOfWeek(TimeCurrent());
   
   // FOMC Meetings (typisch 20:00 UTC+2)
   if(AvoidFOMC && hour == 20 && dow == 3) // Mittwoch
      return true;
   
   // CPI Release (typisch 14:30 UTC+2)  
   if(AvoidCPI && hour == 14 && (dow == 2 || dow == 4)) // Di/Do
      return true;
   
   return false;
}

//+------------------------------------------------------------------+
//| Krypto-Trading Zeit prüfen - Kundenprofil angepasst           |
//+------------------------------------------------------------------+
bool IsCryptoTradingTime()
{
   if(Trade24Hours)
      return true;
   
   datetime currentTime = TimeCurrent();
   int hour = TimeHour(currentTime);
   int minute = TimeMinute(currentTime);
   int dayOfWeek = TimeDayOfWeek(currentTime);
   
   // Wochenend-Check: Nur Sonntag erlaubt
   if(dayOfWeek == 0) // Sonntag
   {
      if(!SundayTradingOnly)
         return false;
   }
   else if(dayOfWeek == 6) // Samstag
   {
      return false; // Samstag komplett gesperrt
   }
   
   // Prüfe eingeschränkte Handelszeiten (15:45 - 17:45)
   if(RestrictedTradingHours)
   {
      int currentMinutes = hour * 60 + minute;
      int startMinutes = TradingStartHour * 60 + TradingStartMinute;
      int endMinutes = TradingEndHour * 60 + TradingEndMinute;
      
      if(currentMinutes < startMinutes || currentMinutes > endMinutes)
         return false;
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| NY Open Boost Zeit prüfen                                      |
//+------------------------------------------------------------------+
bool IsNYOpenTime()
{
   if(!NYOpenFocus)
      return false;
      
   int hour = TimeHour(TimeCurrent());
   int minute = TimeMinute(TimeCurrent());
   int currentMinutes = hour * 60 + minute;
   int nyOpenMinutes = NYOpenHour * 60 + NYOpenMinute;
   
   // 30 Minuten vor bis 60 Minuten nach NY Open
   return (currentMinutes >= (nyOpenMinutes - 30) && currentMinutes <= (nyOpenMinutes + 60));
}

//+------------------------------------------------------------------+
//| Krypto-Marktanalyse                                            |
//+------------------------------------------------------------------+
void AnalyzeCryptoMarket()
{
   // Standard-Analyse mit Krypto-Anpassungen
   AnalyzeCryptoTrendLines();
   AnalyzeCryptoVolume();
   IdentifyCryptoSupportResistance();
   CheckCryptoDivergence();
   CheckCryptoConfirmationSignals();
   AnalyzeCryptoMomentum();
   
   // Krypto-spezifische Analysen
   if(CorrelationFilter)
      AnalyzeBTCCorrelation();
}

//+------------------------------------------------------------------+
//| Krypto-Trendlinien analysieren                                 |
//+------------------------------------------------------------------+
void AnalyzeCryptoTrendLines()
{
   double swingHigh = 0, swingLow = 0;
   int highIndex = 0, lowIndex = 0;
   
   // Swing Highs und Lows finden (angepasst für Krypto-Volatilität)
   for(int i = SwingPeriod; i < Bars - SwingPeriod; i++)
   {
      bool isSwingHigh = true;
      bool isSwingLow = true;
      
      for(int j = 1; j <= SwingPeriod; j++)
      {
         if(High[i] <= High[i-j] || High[i] <= High[i+j])
            isSwingHigh = false;
         if(Low[i] >= Low[i-j] || Low[i] >= Low[i+j])
            isSwingLow = false;
      }
      
      if(isSwingHigh && swingHigh == 0)
      {
         swingHigh = High[i];
         highIndex = i;
      }
      
      if(isSwingLow && swingLow == 0)
      {
         swingLow = Low[i];
         lowIndex = i;
      }
      
      if(swingHigh > 0 && swingLow > 0)
         break;
   }
   
   // Krypto-Trendrichtung bestimmen
   double ema_fast = iMA(NULL, 0, EMA_Fast, 0, MODE_EMA, PRICE_CLOSE, 1);
   double ema_medium = iMA(NULL, 0, EMA_Medium, 0, MODE_EMA, PRICE_CLOSE, 1);
   double ema_slow = iMA(NULL, 0, EMA_Slow, 0, MODE_EMA, PRICE_CLOSE, 1);
   
   // Stärkere Trend-Bestätigung für Krypto
   if(Close[1] > ema_fast && ema_fast > ema_medium && ema_medium > ema_slow)
      TrendDirection = "BULLISH";
   else if(Close[1] < ema_fast && ema_fast < ema_medium && ema_medium < ema_slow)
      TrendDirection = "BEARISH";
   else
      TrendDirection = "RANGING";
   
   // Krypto-Trendlinie zeichnen
   DrawCryptoTrendLine(swingHigh, swingLow, highIndex, lowIndex);
}

//+------------------------------------------------------------------+
//| Krypto-Volume analysieren                                      |
//+------------------------------------------------------------------+
void AnalyzeCryptoVolume()
{
   CurrentVolume = (double)Volume[1];
   
   // Krypto-Volume Durchschnitt
   double volumeSum = 0;
   for(int i = 1; i <= VolumePeriod; i++)
   {
      volumeSum += (double)Volume[i];
   }
   AvgVolume = volumeSum / VolumePeriod;
   
   // Extreme Volume-Spikes für Krypto erkennen
   if(CurrentVolume > AvgVolume * VolumeMultiplier * 2)
   {
      if(EnableAlerts)
         Alert("EXTREME Volume-Spike erkannt! ", CurrentVolume);
      
      // Volatilitäts-Zone zeichnen
      if(ShowVolatilityZones)
         DrawVolatilityZone();
   }
}

//+------------------------------------------------------------------+
//| BTC-Korrelation analysieren                                    |
//+------------------------------------------------------------------+
void AnalyzeBTCCorrelation()
{
   // Vereinfachte BTC-Korrelation
   // In echtem EA würde hier ein BTC-Chart analysiert
   
   string currentSymbol = Symbol();
   
   // Wenn bereits BTC gehandelt wird
   if(StringFind(currentSymbol, "BTC") >= 0)
   {
      BTCBullish = (TrendDirection == "BULLISH");
      return;
   }
   
   // Für andere Kryptos: Annahme basierend auf allgemeinem Trend
   // In Realität: API-Call zu BTC-Daten
   BTCBullish = (TrendDirection == "BULLISH");
}

//+------------------------------------------------------------------+
//| Dynamische Lot-Size Berechnung basierend auf Risiko           |
//+------------------------------------------------------------------+
double CalculateDynamicLotSize()
{
   double balance = AccountBalance();
   if(balance <= 0) balance = AccountBalance; // Fallback auf Parameter
   
   double riskAmount = balance * (CurrentRiskPercent / 100.0);
   double stopLossPoints = SL_Points;
   
   // Für Krypto: SL in Prozent des aktuellen Preises
   if(UseATR_SL)
   {
      double atr = iATR(NULL, 0, ATR_Period, 1);
      stopLossPoints = atr * ATR_Multiplier;
   }
   
   double tickValue = MarketInfo(Symbol(), MODE_TICKVALUE);
   double tickSize = MarketInfo(Symbol(), MODE_TICKSIZE);
   double minLot = MarketInfo(Symbol(), MODE_MINLOT);
   double maxLot = MarketInfo(Symbol(), MODE_MAXLOT);
   
   double lotSize = (riskAmount) / (stopLossPoints * tickValue / tickSize);
   
   // Lot-Size normalisieren
   lotSize = MathMax(lotSize, minLot);
   lotSize = MathMin(lotSize, maxLot);
   
   // Auf erlaubte Lot-Steps runden
   double lotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   lotSize = MathRound(lotSize / lotStep) * lotStep;
   
   return lotSize;
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
         Alert("INFO: Mehr als ", MaxTradesPerDay, " Trades heute - Trader entscheidet selbst!");
   }
}

//+------------------------------------------------------------------+
//| Drawdown Management                                            |
//+------------------------------------------------------------------+
bool CheckDrawdownLimit()
{
   double balance = AccountBalance();
   double equity = AccountEquity();
   
   if(balance > 0)
   {
      CurrentDrawdown = (balance - equity) / balance * 100.0;
      
      if(CurrentDrawdown > MaxDrawdown)
         MaxDrawdown = CurrentDrawdown;
      
      // Stoppe Trading bei zu hohem Drawdown
      if(CurrentDrawdown > MaxDrawdownPercent)
      {
         if(EnableAlerts)
            Alert("DRAWDOWN LIMIT erreicht: ", CurrentDrawdown, "% - Trading gestoppt!");
         return false;
      }
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| Verlust-Serie Management                                       |
//+------------------------------------------------------------------+
void HandleLossStreak()
{
   int consecutiveLosses = 0;
   
   // Zähle aufeinanderfolgende Verluste
   for(int i = OrdersHistoryTotal() - 1; i >= 0; i--)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
      {
         if(OrderMagicNumber() == MagicNumber)
         {
            if(OrderProfit() < 0)
               consecutiveLosses++;
            else
               break;
         }
      }
   }
   
   // Nach 3-5 Verlusten: Risiko reduzieren
   if(consecutiveLosses >= 3 && consecutiveLosses <= 5)
   {
      CurrentRiskPercent = RiskPercent * 0.5; // Halbiere Risiko
      
      if(EnableAlerts)
         Print("Verlust-Serie erkannt (", consecutiveLosses, ") - Risiko reduziert auf ", CurrentRiskPercent, "%");
   }
   else if(consecutiveLosses > 5)
   {
      CurrentRiskPercent = RiskPercent * 0.25; // Noch stärker reduzieren
      
      if(EnableAlerts)
         Alert("Starke Verlust-Serie (", consecutiveLosses, ") - Warte auf klare Marktrichtung!");
   }
   else
   {
      CurrentRiskPercent = RiskPercent; // Normal
   }
}

//+------------------------------------------------------------------+
//| Krypto-Support/Resistance                                      |
//+------------------------------------------------------------------+
void IdentifyCryptoSupportResistance()
{
   double support = 0, resistance = 0;
   
   // Dynamische SR für Krypto-Volatilität
   if(DynamicSR)
   {
      // ATR-basierte SR-Zonen
      double atr = iATR(NULL, 0, ATR_Period, 1);
      support = Low[iLowest(NULL, 0, MODE_LOW, SR_Lookback, 1)] - atr;
      resistance = High[iHighest(NULL, 0, MODE_HIGH, SR_Lookback, 1)] + atr;
   }
   else
   {
      // Klassische SR-Erkennung
      for(int i = 1; i <= SR_Lookback; i++)
      {
         double price = Low[i];
         int touches = CountCryptoPriceTouches(price, LastATR);
         
         if(touches >= SR_Strength && (support == 0 || price > support))
            support = price;
         
         price = High[i];
         touches = CountCryptoPriceTouches(price, LastATR);
         
         if(touches >= SR_Strength && (resistance == 0 || price < resistance))
            resistance = price;
      }
   }
   
   LastSupport = support;
   LastResistance = resistance;
   
   // Krypto-SR Linien zeichnen
   if(support > 0)
      DrawCryptoSupportResistance("Support", support, clrAqua);
   if(resistance > 0)
      DrawCryptoSupportResistance("Resistance", resistance, clrOrange);
}

//+------------------------------------------------------------------+
//| Krypto-Preis Touches zählen                                    |
//+------------------------------------------------------------------+
int CountCryptoPriceTouches(double price, double tolerance)
{
   int touches = 0;
   double cryptoTolerance = MathMax(tolerance, price * 0.01); // Min. 1%
   
   for(int i = 1; i <= SR_Lookback; i++)
   {
      if(MathAbs(Low[i] - price) <= cryptoTolerance || 
         MathAbs(High[i] - price) <= cryptoTolerance)
         touches++;
   }
   
   return touches;
}

//+------------------------------------------------------------------+
//| Krypto-Divergenz prüfen                                        |
//+------------------------------------------------------------------+
void CheckCryptoDivergence()
{
   double rsi1 = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
   double rsi2 = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 8); // Längerer Zeitraum für Krypto
   
   double macd1 = iMACD(NULL, 0, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE, MODE_MAIN, 1);
   double macd2 = iMACD(NULL, 0, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE, MODE_MAIN, 8);
   
   // Stärkere Divergenz-Bestätigung für Krypto
   double priceChange = (Close[1] - Close[8]) / Close[8];
   double rsiChange = (rsi1 - rsi2) / 100;
   
   // Bullish Divergenz
   if(priceChange < -0.02 && rsiChange > 0.1) // Min. 2% Preis-Drop, RSI steigt
   {
      if(EnableAlerts)
         Alert("Starke Bullish Divergenz erkannt!");
      DrawCryptoArrow("BullishDiv", Time[1], Low[1] - 30*Point, 233, clrAqua);
   }
   
   // Bearish Divergenz
   if(priceChange > 0.02 && rsiChange < -0.1) // Min. 2% Preis-Anstieg, RSI fällt
   {
      if(EnableAlerts)
         Alert("Starke Bearish Divergenz erkannt!");
      DrawCryptoArrow("BearishDiv", Time[1], High[1] + 30*Point, 234, clrOrange);
   }
}

//+------------------------------------------------------------------+
//| Krypto-Bestätigungssignale                                     |
//+------------------------------------------------------------------+
void CheckCryptoConfirmationSignals()
{
   BullishSetup = false;
   BearishSetup = false;
   
   // Stärkere Bestätigung für Krypto-Volatilität
   bool strongVolumeConfirmation = (CurrentVolume > AvgVolume * VolumeMultiplier);
   bool volatilityOK = !HighVolatilityPeriod || (HighVolatilityPeriod && strongVolumeConfirmation);
   
   // Krypto-Bullish Confirmation
   bool bullishEngulfing = (Close[1] > Open[1] && Close[2] < Open[2] && 
                           Open[1] < Close[2] && Close[1] > Open[2]);
   bool strongBullishCandle = ((Close[1] - Open[1]) / Open[1]) > 0.015; // Min. 1.5%
   bool nearSupport = (LastSupport > 0 && Low[1] <= LastSupport + LastATR);
   
   if((bullishEngulfing || strongBullishCandle) && strongVolumeConfirmation && 
      volatilityOK && TrendDirection != "BEARISH")
   {
      BullishSetup = true;
      if(EnableAlerts)
         Alert("Starkes Bullish Setup erkannt!");
   }
   
   // Krypto-Bearish Confirmation
   bool bearishEngulfing = (Close[1] < Open[1] && Close[2] > Open[2] && 
                           Open[1] > Close[2] && Close[1] < Open[2]);
   bool strongBearishCandle = ((Open[1] - Close[1]) / Open[1]) > 0.015; // Min. 1.5%
   bool nearResistance = (LastResistance > 0 && High[1] >= LastResistance - LastATR);
   
   if((bearishEngulfing || strongBearishCandle) && strongVolumeConfirmation && 
      volatilityOK && TrendDirection != "BULLISH")
   {
      BearishSetup = true;
      if(EnableAlerts)
         Alert("Starkes Bearish Setup erkannt!");
   }
}

//+------------------------------------------------------------------+
//| Krypto-Momentum analysieren                                    |
//+------------------------------------------------------------------+
void AnalyzeCryptoMomentum()
{
   double ema_fast = iMA(NULL, 0, EMA_Fast, 0, MODE_EMA, PRICE_CLOSE, 1);
   double ema_medium = iMA(NULL, 0, EMA_Medium, 0, MODE_EMA, PRICE_CLOSE, 1);
   double ema_slow = iMA(NULL, 0, EMA_Slow, 0, MODE_EMA, PRICE_CLOSE, 1);
   
   // Krypto-spezifisches Momentum
   double momentumStrength = CalculateMomentumStrength();
   
   // Bullish Momentum (stärker für Krypto)
   bool strongBullishMomentum = (momentumStrength > 0.02); // Min. 2%
   bool emaAlignment = (ema_fast > ema_medium && ema_medium > ema_slow);
   bool increasingVolume = (CurrentVolume > AvgVolume * 1.5);
   
   if(strongBullishMomentum && emaAlignment && increasingVolume)
   {
      BullishSetup = true;
   }
   
   // Bearish Momentum
   bool strongBearishMomentum = (momentumStrength < -0.02); // Min. -2%
   bool bearishEmaAlignment = (ema_fast < ema_medium && ema_medium < ema_slow);
   
   if(strongBearishMomentum && bearishEmaAlignment && increasingVolume)
   {
      BearishSetup = true;
   }
}

//+------------------------------------------------------------------+
//| Momentum-Stärke berechnen                                      |
//+------------------------------------------------------------------+
double CalculateMomentumStrength()
{
   double recentChange = (Close[1] - Close[5]) / Close[5];
   double volumeWeight = CurrentVolume / AvgVolume;
   
   return recentChange * MathMin(volumeWeight, 3.0); // Max. 3x Gewichtung
}

//+------------------------------------------------------------------+
//| Krypto-Trading Signale prüfen                                  |
//+------------------------------------------------------------------+
void CheckCryptoTradingSignals()
{
   // Keine neuen Trades bei extremer Volatilität ohne Volume
   if(HighVolatilityPeriod && CurrentVolume < AvgVolume * VolumeMultiplier)
      return;
   
   // Keine neuen Trades wenn bereits Position offen
   if(OrdersTotal() > 0)
      return;
   
   // Korrelations-Filter
   if(CorrelationFilter && !BTCBullish && BullishSetup)
   {
      Print("BTC-Korrelation verhindert Bullish Trade");
      return;
   }
   
   // Krypto-Bullish Entry
   if(BullishSetup && TrendDirection != "BEARISH")
   {
      double sl = CalculateCryptoStopLoss(OP_BUY);
      double tp = CalculateCryptoTakeProfit(OP_BUY, sl);
      
      if(OpenCryptoTrade(OP_BUY, sl, tp))
      {
         if(ShowEntryArrows)
            DrawCryptoEntryArrow("CryptoBuy_" + TimeToStr(Time[0]), Time[0],
                               Low[0] - 20*Point, 233, clrLime, "BUY");
         
         if(EnableSounds)
            PlaySound(SoundFileEntry);
         if(EnableAlerts)
            Alert("CRYPTO BUY SIGNAL! ", Symbol(), " @ ", DoubleToStr(Ask, Digits));
         
         WaitingForExit = true;
         LastTradeTime = Time[0];
      }
   }
   
   // Krypto-Bearish Entry
   if(BearishSetup && TrendDirection != "BULLISH")
   {
      double sl = CalculateCryptoStopLoss(OP_SELL);
      double tp = CalculateCryptoTakeProfit(OP_SELL, sl);
      
      if(OpenCryptoTrade(OP_SELL, sl, tp))
      {
         if(ShowEntryArrows)
            DrawCryptoEntryArrow("CryptoSell_" + TimeToStr(Time[0]), Time[0],
                               High[0] + 20*Point, 234, clrRed, "SELL");
         
         if(EnableSounds)
            PlaySound(SoundFileEntry);
         if(EnableAlerts)
            Alert("CRYPTO SELL SIGNAL! ", Symbol(), " @ ", DoubleToStr(Bid, Digits));
         
         WaitingForExit = true;
         LastTradeTime = Time[0];
      }
   }
}

//+------------------------------------------------------------------+
//| Krypto-Stop Loss berechnen                                     |
//+------------------------------------------------------------------+
double CalculateCryptoStopLoss(int orderType)
{
   double sl = 0;
   double atr = iATR(NULL, 0, ATR_Period, 1);
   double minStopLevel = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
   
   // Krypto-angepasste SL-Berechnung
   double cryptoSLDistance = MathMax(atr * ATR_Multiplier, minStopLevel * 3);
   
   // Bei hoher Volatilität größeren SL
   if(HighVolatilityPeriod)
      cryptoSLDistance *= 1.5;
   
   if(orderType == OP_BUY)
      sl = Bid - cryptoSLDistance;
   else
      sl = Ask + cryptoSLDistance;
   
   return NormalizeDouble(sl, Digits);
}

//+------------------------------------------------------------------+
//| Krypto-Take Profit berechnen                                   |
//+------------------------------------------------------------------+
double CalculateCryptoTakeProfit(int orderType, double stopLoss)
{
   double tp = 0;
   double slDistance = 0;
   double minStopLevel = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
   
   if(orderType == OP_BUY)
   {
      slDistance = Bid - stopLoss;
      tp = Bid + (slDistance * RiskRewardRatio);
      
      // KUNDENPROFIL: Höhere Gewinne bevorzugt - erweiterte TP-Berechnung
      if(IsNYOpenTime())
      {
         // NY Open: Aggressiveres TP für höhere Gewinne
         tp = Bid + (slDistance * (RiskRewardRatio + 0.5));
      }
      
      // Krypto-Anpassung an Resistance mit verbesserter Logik
      if(LastResistance > 0 && tp > LastResistance)
      {
         double distanceToResistance = LastResistance - Bid;
         if(distanceToResistance > minStopLevel * 2)
         {
            // Prüfe ob zweites TP-Level möglich ist
            double tp2Distance = LastResistance - Bid + (LastATR * 1.5);
            if(tp2Distance / slDistance >= RiskRewardRatio)
               tp = LastResistance + (LastATR * 0.5); // Über Resistance
            else
               tp = LastResistance - (LastATR * 0.3); // Vor Resistance
         }
      }
   }
   else
   {
      slDistance = stopLoss - Ask;
      tp = Ask - (slDistance * RiskRewardRatio);
      
      // KUNDENPROFIL: NY Open Boost
      if(IsNYOpenTime())
      {
         tp = Ask - (slDistance * (RiskRewardRatio + 0.5));
      }
      
      // Krypto-Anpassung an Support mit verbesserter Logik
      if(LastSupport > 0 && tp < LastSupport)
      {
         double distanceToSupport = Ask - LastSupport;
         if(distanceToSupport > minStopLevel * 2)
         {
            // Prüfe ob zweites TP-Level möglich ist
            double tp2Distance = Ask - LastSupport + (LastATR * 1.5);
            if(tp2Distance / slDistance >= RiskRewardRatio)
               tp = LastSupport - (LastATR * 0.5); // Unter Support
            else
               tp = LastSupport + (LastATR * 0.3); // Vor Support
         }
      }
   }
   
   return NormalizeDouble(tp, Digits);
}

//+------------------------------------------------------------------+
//| Krypto-Trade öffnen                                            |
//+------------------------------------------------------------------+
bool OpenCryptoTrade(int orderType, double stopLoss, double takeProfit)
{
   double price = (orderType == OP_BUY) ? Ask : Bid;
   double minStopLevel = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
   
   // Krypto-spezifische Validierung
   if(orderType == OP_BUY)
   {
      if(stopLoss > 0 && (price - stopLoss) < minStopLevel * 2)
      {
         Print("Krypto-SL zu nah am Preis. ATR: ", LastATR);
         stopLoss = price - (LastATR * ATR_Multiplier);
      }
      if(takeProfit > 0 && (takeProfit - price) < minStopLevel * 2)
      {
         takeProfit = price + (LastATR * ATR_Multiplier * RiskRewardRatio);
      }
   }
   else
   {
      if(stopLoss > 0 && (stopLoss - price) < minStopLevel * 2)
      {
         Print("Krypto-SL zu nah am Preis. ATR: ", LastATR);
         stopLoss = price + (LastATR * ATR_Multiplier);
      }
      if(takeProfit > 0 && (price - takeProfit) < minStopLevel * 2)
      {
         takeProfit = price - (LastATR * ATR_Multiplier * RiskRewardRatio);
      }
   }
   
   // KUNDENPROFIL: Dynamische Lot-Größe verwenden
   double minLot = MarketInfo(Symbol(), MODE_MINLOT);
   double maxLot = MarketInfo(Symbol(), MODE_MAXLOT);
   double lotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   
   double validLotSize = MathMax(minLot, MathMin(maxLot, CalculatedLotSize));
   validLotSize = NormalizeDouble(validLotSize / lotStep, 0) * lotStep;
   
   // Bei hoher Volatilität kleinere Lot-Größe
   if(HighVolatilityPeriod)
      validLotSize *= 0.7;
   
   // NY Open Boost: Größere Lot-Size möglich
   if(NYOpenBoost && IsNYOpenTime())
      validLotSize *= 1.2;
   
   // Trade senden
   int slippage = 10; // Höhere Slippage für Krypto
   int ticket = OrderSend(Symbol(), orderType, validLotSize, price, slippage,
                         stopLoss, takeProfit, "CryptoEA", MagicNumber, 0,
                         (orderType == OP_BUY) ? clrLime : clrRed);
   
   if(ticket > 0)
   {
      // KUNDENPROFIL: Trade-Counter aktualisieren
      TradesToday++;
      TotalTrades++;
      LastTradeTime = TimeCurrent();
      
      Print("KUNDENPROFIL-Trade eroeffnet: ", (orderType == OP_BUY) ? "BUY" : "SELL",
            " Lots:", validLotSize, " (Risiko: ", CurrentRiskPercent, "%)",
            " Trades heute: ", TradesToday, "/", MaxTradesPerDay,
            " Preis:", price, " SL:", stopLoss, " TP:", takeProfit);
      
      if(EnableAlerts)
         Alert("Trade ", TradesToday, "/", MaxTradesPerDay, " - ",
               (orderType == OP_BUY) ? "BUY" : "SELL", " ", Symbol());
      
      return true;
   }
   else
   {
      int error = GetLastError();
      Print("Krypto-Trade Fehler: ", error, " - ", ErrorDescription(error));
      return false;
   }
}

//+------------------------------------------------------------------+
//| Krypto-Positionen überwachen                                   |
//+------------------------------------------------------------------+
void MonitorCryptoPositions()
{
   for(int i = OrdersTotal() - 1; i >= 0; i--)
   {
      if(OrderSelect(i, SELECT_BY_POS) && OrderMagicNumber() == MagicNumber)
      {
         bool shouldExit = false;
         string exitReason = "";
         
         // Krypto-spezifische Exit-Bedingungen
         if(OrderType() == OP_BUY)
         {
            // Bearish-Signale oder extreme Überkauft
            if(BearishSetup || TrendDirection == "BEARISH")
            {
               shouldExit = true;
               exitReason = "Bearish Signal";
            }
            
            double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
            if(rsi > RSI_Overbought)
            {
               shouldExit = true;
               exitReason = "RSI Überkauft";
            }
            
            // Krypto: Bei extremer Volatilität aussteigen
            if(HighVolatilityPeriod && CurrentVolume < AvgVolume)
            {
               shouldExit = true;
               exitReason = "Extreme Volatilität";
            }
         }
         else if(OrderType() == OP_SELL)
         {
            // Bullish-Signale oder extreme Überverkauft
            if(BullishSetup || TrendDirection == "BULLISH")
            {
               shouldExit = true;
               exitReason = "Bullish Signal";
            }
            
            double rsi = iRSI(NULL, 0, RSI_Period, PRICE_CLOSE, 1);
            if(rsi < RSI_Oversold)
            {
               shouldExit = true;
               exitReason = "RSI Überverkauft";
            }
            
            if(HighVolatilityPeriod && CurrentVolume < AvgVolume)
            {
               shouldExit = true;
               exitReason = "Extreme Volatilität";
            }
         }
         
         // Trailing Stop für Krypto
         if(TrailingSL && !shouldExit)
         {
            UpdateCryptoTrailingStop(OrderTicket());
         }
         
         // Exit durchführen
         if(shouldExit)
         {
            ExecuteCryptoExit(OrderTicket(), exitReason);
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Krypto-Trailing Stop aktualisieren                             |
//+------------------------------------------------------------------+
void UpdateCryptoTrailingStop(int ticket)
{
   if(!OrderSelect(ticket, SELECT_BY_TICKET))
      return;
   
   double newSL = 0;
   double trailDistance = TrailingDistance * Point;
   
   if(OrderType() == OP_BUY)
   {
      newSL = Bid - trailDistance;
      if(newSL > OrderStopLoss() && newSL < Bid)
      {
         if(OrderModify(ticket, OrderOpenPrice(), newSL, OrderTakeProfit(), 0))
            Print("Trailing Stop aktualisiert: ", newSL);
      }
   }
   else if(OrderType() == OP_SELL)
   {
      newSL = Ask + trailDistance;
      if((OrderStopLoss() == 0 || newSL < OrderStopLoss()) && newSL > Ask)
      {
         if(OrderModify(ticket, OrderOpenPrice(), newSL, OrderTakeProfit(), 0))
            Print("Trailing Stop aktualisiert: ", newSL);
      }
   }
}

//+------------------------------------------------------------------+
//| Krypto-Exit ausführen                                          |
//+------------------------------------------------------------------+
void ExecuteCryptoExit(int ticket, string reason)
{
   if(OrderSelect(ticket, SELECT_BY_TICKET))
   {
      double closePrice = (OrderType() == OP_BUY) ? Bid : Ask;
      
      if(OrderClose(ticket, OrderLots(), closePrice, 10))
      {
         // Gewinn/Verlust berechnen
         double profit = OrderProfit() + OrderCommission() + OrderSwap();
         bool isWin = profit > 0;
         
         // Statistiken aktualisieren
         TotalTrades++;
         TotalProfit += profit;
         if(isWin)
            WinningTrades++;
         else
            LosingTrades++;
         
         // Krypto-Exit Visualisierung
         if(ShowExitArrows)
         {
            color arrowColor = isWin ? clrLime : clrRed;
            int arrowCode = (OrderType() == OP_BUY) ? 242 : 241;
            DrawCryptoExitArrow("CryptoExit_" + TimeToStr(Time[0]), Time[0],
                              (OrderType() == OP_BUY) ? High[0] + 15*Point : Low[0] - 15*Point,
                              arrowCode, arrowColor);
         }
         
         // Erfolgs-Symbol
         if(ShowSuccessSymbols)
         {
            DrawCryptoSuccessSymbol("CryptoResult_" + TimeToStr(Time[0]), Time[0], Close[0], isWin, profit);
         }
         
         // Sound und Alert
         if(EnableSounds)
         {
            if(isWin)
               PlaySound(SoundFileWin);
            else
               PlaySound(SoundFileLoss);
         }
         
         string alertMsg = " CRYPTO EXIT: " + reason + " | " +
                          (isWin ? "GEWINN" : "VERLUST") + " | " +
                          DoubleToStr(profit, 2) + " " + AccountCurrency();
         
         if(EnableAlerts)
            Alert(alertMsg);
         
         Print(alertMsg);
         WaitingForExit = false;
      }
   }
}

//+------------------------------------------------------------------+
//| Fehlerbeschreibung                                              |
//+------------------------------------------------------------------+
string ErrorDescription(int errorCode)
{
   switch(errorCode)
   {
      case 130: return "Invalid stops (SL/TP zu nah)";
      case 131: return "Invalid trade volume";
      case 132: return "Market is closed";
      case 133: return "Trade is disabled";
      case 134: return "Not enough money";
      case 135: return "Price changed";
      case 136: return "Off quotes";
      case 137: return "Broker is busy";
      case 138: return "Requote";
      case 139: return "Order is locked";
      default: return "Error " + IntegerToString(errorCode);
   }
}

//+------------------------------------------------------------------+
//| Krypto-Trendlinie zeichnen                                     |
//+------------------------------------------------------------------+
void DrawCryptoTrendLine(double high, double low, int highIndex, int lowIndex)
{
   string name = "CryptoTrend_" + TimeToStr(Time[0]);
   
   ObjectDelete(name);
   ObjectCreate(name, OBJ_TREND, 0, Time[highIndex], high, Time[lowIndex], low);
   ObjectSet(name, OBJPROP_COLOR, clrGold);
   ObjectSet(name, OBJPROP_WIDTH, 3);
   ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(name, OBJPROP_RAY, true);
}

//+------------------------------------------------------------------+
//| Krypto-Support/Resistance zeichnen                             |
//+------------------------------------------------------------------+
void DrawCryptoSupportResistance(string name, double price, color clr)
{
   ObjectDelete(name);
   ObjectCreate(name, OBJ_HLINE, 0, 0, price);
   ObjectSet(name, OBJPROP_COLOR, clr);
   ObjectSet(name, OBJPROP_WIDTH, 2);
   ObjectSet(name, OBJPROP_STYLE, STYLE_DASH);
}

//+------------------------------------------------------------------+
//| Krypto-Pfeil zeichnen                                          |
//+------------------------------------------------------------------+
void DrawCryptoArrow(string name, datetime time, double price, int arrowCode, color clr)
{
   ObjectDelete(name);
   ObjectCreate(name, OBJ_ARROW, 0, time, price);
   ObjectSet(name, OBJPROP_ARROWCODE, arrowCode);
   ObjectSet(name, OBJPROP_COLOR, clr);
   ObjectSet(name, OBJPROP_WIDTH, ArrowSize);
}

//+------------------------------------------------------------------+
//| Krypto-Entry Pfeil                                             |
//+------------------------------------------------------------------+
void DrawCryptoEntryArrow(string name, datetime time, double price, int arrowCode, color clr, string direction)
{
   ObjectDelete(name);
   ObjectCreate(name, OBJ_ARROW, 0, time, price);
   ObjectSet(name, OBJPROP_ARROWCODE, arrowCode);
   ObjectSet(name, OBJPROP_COLOR, clr);
   ObjectSet(name, OBJPROP_WIDTH, ArrowSize);
   
   // Krypto-Label
   string labelName = name + "_Label";
   ObjectDelete(labelName);
   ObjectCreate(labelName, OBJ_TEXT, 0, time, price);
   ObjectSetText(labelName, direction, 12, "Arial Black", clr);
}

//+------------------------------------------------------------------+
//| Krypto-Exit Pfeil                                              |
//+------------------------------------------------------------------+
void DrawCryptoExitArrow(string name, datetime time, double price, int arrowCode, color clr)
{
   ObjectDelete(name);
   ObjectCreate(name, OBJ_ARROW, 0, time, price);
   ObjectSet(name, OBJPROP_ARROWCODE, arrowCode);
   ObjectSet(name, OBJPROP_COLOR, clr);
   ObjectSet(name, OBJPROP_WIDTH, ArrowSize);
}

//+------------------------------------------------------------------+
//| Krypto-Erfolgs Symbol                                          |
//+------------------------------------------------------------------+
void DrawCryptoSuccessSymbol(string name, datetime time, double price, bool isWin, double profit)
{
   ObjectDelete(name);
   
   if(isWin)
   {
      ObjectCreate(name, OBJ_ARROW, 0, time, price + 25*Point);
      ObjectSet(name, OBJPROP_ARROWCODE, 252); // Häkchen
      ObjectSet(name, OBJPROP_COLOR, clrLime);
   }
   else
   {
      ObjectCreate(name, OBJ_ARROW, 0, time, price - 25*Point);
      ObjectSet(name, OBJPROP_ARROWCODE, 251); // X
      ObjectSet(name, OBJPROP_COLOR, clrRed);
   }
   
   ObjectSet(name, OBJPROP_WIDTH, 3);
   
   // Profit-Text
   string textName = name + "_Profit";
   ObjectDelete(textName);
   ObjectCreate(textName, OBJ_TEXT, 0, time, price + (isWin ? 35*Point : -35*Point));
   string profitText = (isWin ? "+" : "") + DoubleToStr(profit, 2);
   ObjectSetText(textName, profitText, 10, "Arial Bold", isWin ? clrLime : clrRed);
}

//+------------------------------------------------------------------+
//| Volatilitäts-Zone zeichnen                                     |
//+------------------------------------------------------------------+
void DrawVolatilityZone()
{
   string name = "VolZone_" + TimeToStr(Time[0]);
   ObjectDelete(name);
   
   double high = High[0] + LastATR;
   double low = Low[0] - LastATR;
   
   ObjectCreate(name, OBJ_RECTANGLE, 0, Time[5], high, Time[0], low);
   ObjectSet(name, OBJPROP_COLOR, clrDarkOrange);
   ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
   ObjectSet(name, OBJPROP_BACK, true);
}

//+------------------------------------------------------------------+
//| Krypto-Dashboard erstellen                                     |
//+------------------------------------------------------------------+
void CreateCryptoDashboard()
{
   // Hauptpanel - Erweitert für Kundenprofil
   ObjectCreate("CryptoDashboard", OBJ_RECTANGLE_LABEL, 0, 0, 0);
   ObjectSet("CryptoDashboard", OBJPROP_XDISTANCE, DashboardX);
   ObjectSet("CryptoDashboard", OBJPROP_YDISTANCE, DashboardY);
   ObjectSet("CryptoDashboard", OBJPROP_XSIZE, 380);
   ObjectSet("CryptoDashboard", OBJPROP_YSIZE, 400);
   ObjectSet("CryptoDashboard", OBJPROP_BGCOLOR, clrDarkSlateGray);
   ObjectSet("CryptoDashboard", OBJPROP_BORDER_COLOR, clrGold);
   ObjectSet("CryptoDashboard", OBJPROP_BORDER_TYPE, BORDER_FLAT);
   
   // Labels - Standard
   CreateCryptoLabel("Crypto_Title", "SCALPING EA - KUNDENPROFIL", DashboardX + 10, DashboardY + 10, clrGold, 11);
   CreateCryptoLabel("Crypto_Symbol", "", DashboardX + 10, DashboardY + 30, clrWhite, 10);
   CreateCryptoLabel("Crypto_Trend", "", DashboardX + 10, DashboardY + 50, clrWhite, 10);
   CreateCryptoLabel("Crypto_Volume", "", DashboardX + 10, DashboardY + 70, clrWhite, 10);
   CreateCryptoLabel("Crypto_Volatility", "", DashboardX + 10, DashboardY + 90, clrWhite, 10);
   CreateCryptoLabel("Crypto_Setup", "", DashboardX + 10, DashboardY + 110, clrWhite, 10);
   CreateCryptoLabel("Crypto_Support", "", DashboardX + 10, DashboardY + 130, clrWhite, 10);
   CreateCryptoLabel("Crypto_Resistance", "", DashboardX + 10, DashboardY + 150, clrWhite, 10);
   
   // KUNDENPROFIL-LABELS
   CreateCryptoLabel("Crypto_DailyTrades", "", DashboardX + 10, DashboardY + 180, clrWhite, 10);
   CreateCryptoLabel("Crypto_Risk", "", DashboardX + 10, DashboardY + 200, clrWhite, 10);
   CreateCryptoLabel("Crypto_Drawdown", "", DashboardX + 10, DashboardY + 220, clrWhite, 10);
   CreateCryptoLabel("Crypto_TradingTime", "", DashboardX + 10, DashboardY + 240, clrWhite, 10);
   CreateCryptoLabel("Crypto_CurrentSymbol", "", DashboardX + 10, DashboardY + 260, clrWhite, 10);
   CreateCryptoLabel("Crypto_NewsFilter", "", DashboardX + 10, DashboardY + 280, clrWhite, 10);
   
   // Status & Statistiken
   CreateCryptoLabel("Crypto_Status", "", DashboardX + 10, DashboardY + 300, clrWhite, 10);
   CreateCryptoLabel("Crypto_Stats", "", DashboardX + 10, DashboardY + 320, clrWhite, 10);
   CreateCryptoLabel("Crypto_Profit", "", DashboardX + 10, DashboardY + 340, clrWhite, 10);
   CreateCryptoLabel("Crypto_WinRate", "", DashboardX + 10, DashboardY + 360, clrWhite, 10);
   CreateCryptoLabel("Crypto_BTC", "", DashboardX + 10, DashboardY + 380, clrWhite, 10);
}

//+------------------------------------------------------------------+
//| Professionelles Chart-Design Setup                             |
//+------------------------------------------------------------------+
void SetupProfessionalChartDesign()
{
   Print("Lade professionelles Krypto-Chart Design...");
   
   // === HINTERGRUND & GRID ===
   ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrBlack);              // Schwarzer Hintergrund
   ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrWhite);              // Weißer Text
   ChartSetInteger(0, CHART_COLOR_GRID, clrDarkGray);                 // Dunkles Grid
   ChartSetInteger(0, CHART_SHOW_GRID, true);                         // Grid aktivieren
   
   // === KRYPTO-OPTIMIERTE KERZEN-FARBEN ===
   ChartSetInteger(0, CHART_COLOR_CHART_UP, clrLime);                 // Lime für Bullish
   ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrDeepPink);           // Pink für Bearish
   ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrGreen);             // Grün für Bull Körper
   ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrCrimson);           // Crimson für Bear Körper
   
   // === CHART-STIL ===
   ChartSetInteger(0, CHART_MODE, CHART_CANDLES);                      // Kerzen-Modus
   ChartSetInteger(0, CHART_SHIFT, true);                              // Chart-Verschiebung
   ChartSetInteger(0, CHART_AUTOSCROLL, true);                         // Auto-Scroll
   ChartSetInteger(0, CHART_SCALE_PT_PER_BAR, true);                   // Preis-Skalierung
   
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
   
   // === PERIODE SEPARATOREN ===
   ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, true);                    // Perioden-Trenner
   // CHART_COLOR_PERIOD_SEP nicht verfügbar in MQL4
   
   // === CROSSHAIR ===
   ChartSetInteger(0, CHART_COLOR_LAST, clrGold);                      // Gold für letzte Kerze
   
   // === OHLC-LINIE FARBEN ===
   ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrCyan);                // Cyan für Linie
   
   // === MARGINS & SCALE ===
   // CHART_MARGIN_RIGHT nicht verfügbar in MQL4 - verwende CHART_SHIFT
   ChartSetInteger(0, CHART_SHIFT, true);                              // Chart-Shift aktivieren
   ChartSetDouble(0, CHART_SHIFT_SIZE, 20.0);                          // Shift-Größe
   
   // === ZUSÄTZLICHE PROFESSIONELLE EINSTELLUNGEN ===
   ChartSetInteger(0, CHART_DRAG_TRADE_LEVELS, true);                  // Drag Trade Levels
   ChartSetInteger(0, CHART_COLOR_CHART_UP, clrLimeGreen);             // Lime Green für Up
   ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrDeepPink);            // Rose für Down
   
   // Spezieller Krypto-Indikator Style
   ApplyCryptoIndicatorStyles();
   
   Print("Professionelles Krypto-Design geladen!");
   Print("Bullish Kerzen: Neon-Gruen | Bearish Kerzen: Pink");
   Print("Ask: Hot Pink | Bid: Deep Sky Blue");
}

//+------------------------------------------------------------------+
//| Krypto-Indikator Styles anwenden                               |
//+------------------------------------------------------------------+
void ApplyCryptoIndicatorStyles()
{
   // Definiere professionelle Krypto-Farben
   color cryptoGold = clrGold;                   // Gold
   color cryptoSilver = clrSilver;               // Silber
   color cryptoBlue = clrDeepSkyBlue;            // Deep Sky Blue
   color cryptoPurple = clrMediumSlateBlue;      // Medium Slate Blue
   color cryptoOrange = clrDarkOrange;           // Dark Orange
   
   // Diese Farben können für MA, RSI, MACD etc. verwendet werden
   // Sie werden automatisch beim Hinzufügen von Indikatoren angewendet
   
   Print("Krypto-Indikator Farbpalette aktiviert");
   
   // Zeichne Trading-Zeit Highlights
   if(RestrictedTradingHours)
      DrawTradingTimeZones();
}

//+------------------------------------------------------------------+
//| Trading-Zeit Zonen visuell hervorheben                         |
//+------------------------------------------------------------------+
void DrawTradingTimeZones()
{
   // NY Open Zeit hervorheben (15:30 deutsche Zeit)
   datetime nyOpenStart = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE) + " 15:30");
   datetime nyOpenEnd = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE) + " 16:30");
   
   // Trading-Zeit Zone (15:45-17:45)
   datetime tradingStart = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE) + " 15:45");
   datetime tradingEnd = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE) + " 17:45");
   
   // NY Open Zone - Spezielle Hervorhebung
   ObjectCreate("NYOpenZone", OBJ_RECTANGLE, 0, nyOpenStart, High[1] + 50*Point,
                nyOpenEnd, Low[1] - 50*Point);
   ObjectSet("NYOpenZone", OBJPROP_COLOR, clrDarkBlue);          // Dunkles Blau
   ObjectSet("NYOpenZone", OBJPROP_BACK, true);
   ObjectSet("NYOpenZone", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("NYOpenZone", OBJPROP_WIDTH, 1);
   
   // Trading-Zeit Zone
   ObjectCreate("TradingZone", OBJ_RECTANGLE, 0, tradingStart, High[1] + 30*Point,
                tradingEnd, Low[1] - 30*Point);
   ObjectSet("TradingZone", OBJPROP_COLOR, clrDarkGreen);         // Dunkles Grün
   ObjectSet("TradingZone", OBJPROP_BACK, true);
   ObjectSet("TradingZone", OBJPROP_STYLE, STYLE_DOT);
   ObjectSet("TradingZone", OBJPROP_WIDTH, 1);
   
   Print("Trading-Zeit Zonen gezeichnet: NY Open (15:30-16:30), Trading (15:45-17:45)");
}

//+------------------------------------------------------------------+
//| Krypto-Label erstellen                                         |
//+------------------------------------------------------------------+
void CreateCryptoLabel(string name, string text, int x, int y, color clr, int fontSize)
{
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(name, text, fontSize, "Arial", clr);
   ObjectSet(name, OBJPROP_XDISTANCE, x);
   ObjectSet(name, OBJPROP_YDISTANCE, y);
}

//+------------------------------------------------------------------+
//| Krypto-Dashboard aktualisieren                                 |
//+------------------------------------------------------------------+
void UpdateCryptoDashboard()
{
   ObjectSetText("Crypto_Symbol", Symbol(), 12, "Arial Bold", clrAqua);
   
   color trendColor = clrWhite;
   if(TrendDirection == "BULLISH") { trendColor = clrLime; }
   if(TrendDirection == "BEARISH") { trendColor = clrRed; }
   ObjectSetText("Crypto_Trend", "Trend: " + TrendDirection, 10, "Arial", trendColor);
   
   string volumeStatus = (CurrentVolume > AvgVolume * VolumeMultiplier) ? "HIGH" : "NORMAL";
   ObjectSetText("Crypto_Volume", "Volume: " + volumeStatus, 10, "Arial", clrWhite);
   
   string volText = "Volatilitaet: " + DoubleToStr(CurrentVolatility * 100, 2) + "%";
   color volColor = HighVolatilityPeriod ? clrOrange : clrWhite;
   ObjectSetText("Crypto_Volatility", volText, 10, "Arial", volColor);
   
   string setupStatus = "WAITING";
   color setupColor = clrWhite;
   if(BullishSetup) { setupStatus = "BULLISH"; setupColor = clrLime; }
   if(BearishSetup) { setupStatus = "BEARISH"; setupColor = clrRed; }
   ObjectSetText("Crypto_Setup", "Setup: " + setupStatus, 10, "Arial", setupColor);
   
   ObjectSetText("Crypto_Support", "Support: " + DoubleToStr(LastSupport, Digits), 10, "Arial", clrAqua);
   ObjectSetText("Crypto_Resistance", "Resistance: " + DoubleToStr(LastResistance, Digits), 10, "Arial", clrOrange);
   
   string status = "";
   if(OrdersTotal() > 0)
   {
      if(WaitingForExit)
         status = "MONITORING EXIT";
      else
         status = "POSITION OPEN";
   }
   else
   {
      status = "SCANNING MARKET";
   }
   ObjectSetText("Crypto_Status", "Status: " + status, 10, "Arial", clrWhite);
   
   string statsText = "Trades: " + IntegerToString(TotalTrades) + " | W:" + IntegerToString(WinningTrades) + " L:" + IntegerToString(LosingTrades);
   ObjectSetText("Crypto_Stats", statsText, 10, "Arial", clrWhite);
   
   color profitColor = (TotalProfit >= 0) ? clrLime : clrRed;
   string profitText = "Profit: " + DoubleToStr(TotalProfit, 2) + " " + AccountCurrency();
   ObjectSetText("Crypto_Profit", profitText, 10, "Arial", profitColor);
   
   double winRate = 0;
   if(TotalTrades > 0)
      winRate = (WinningTrades * 100.0) / TotalTrades;
   string winRateText = "Win-Rate: " + DoubleToStr(winRate, 1) + "%";
   color winRateColor = (winRate >= 70) ? clrLime : (winRate >= 50) ? clrYellow : clrRed;
   ObjectSetText("Crypto_WinRate", winRateText, 10, "Arial", winRateColor);
   
   string btcStatus = BTCBullish ? "BULLISH" : "BEARISH";
   color btcColor = BTCBullish ? clrLime : clrRed;
   ObjectSetText("Crypto_BTC", "BTC Trend: " + btcStatus, 10, "Arial", btcColor);
   
   // KUNDENPROFIL-DASHBOARD ERWEITERUNGEN
   
   // Trades pro Tag (Info ohne Beschränkung)
   string tradeCountText = "Heute: " + IntegerToString(TradesToday) + " Trades (Empfehlung: " + IntegerToString(MaxTradesPerDay) + ")";
   color tradeCountColor;
   if(TradesToday > MaxTradesPerDay)
      tradeCountColor = clrOrange; // Warnung aber kein Stopp
   else if(TradesToday >= MaxTradesPerDay)
      tradeCountColor = clrYellow; // Am Limit
   else
      tradeCountColor = clrLime; // Unter Empfehlung
   ObjectSetText("Crypto_DailyTrades", tradeCountText, 10, "Arial", tradeCountColor);
   
   // Aktuelles Risiko
   string riskText = "Risiko: " + DoubleToStr(CurrentRiskPercent, 1) + "% (" + DoubleToStr(CalculatedLotSize, 3) + " Lots)";
   color riskColor = (CurrentRiskPercent < RiskPercent) ? clrYellow : clrWhite;
   ObjectSetText("Crypto_Risk", riskText, 10, "Arial", riskColor);
   
   // Drawdown Status
   string ddText = "Drawdown: " + DoubleToStr(CurrentDrawdown, 1) + "% (Max: " + DoubleToStr(MaxDrawdownPercent, 1) + "%)";
   color ddColor = (CurrentDrawdown > MaxDrawdownPercent * 0.8) ? clrRed : (CurrentDrawdown > MaxDrawdownPercent * 0.6) ? clrYellow : clrLime;
   ObjectSetText("Crypto_Drawdown", ddText, 10, "Arial", ddColor);
   
   // Trading-Zeit Status (Info ohne Beschränkung)
   string timeStatus = "";
   color timeColor;
   if(IsCryptoTradingTime())
   {
      if(IsNYOpenTime())
      {
         timeStatus = "NY OPEN - OPTIMAL";
         timeColor = clrAqua;
      }
      else
      {
         timeStatus = "EMPFOHLENE ZEIT";
         timeColor = clrLime;
      }
   }
   else
   {
      timeStatus = "AUSSERHALB EMPF. ZEIT";
      timeColor = clrYellow; // Warnung statt Grau
   }
   ObjectSetText("Crypto_TradingTime", timeStatus, 10, "Arial", timeColor);
   
   // Aktuelles Symbol anzeigen
   string currentSymbolText = "Symbol: " + Symbol();
   ObjectSetText("Crypto_CurrentSymbol", currentSymbolText, 10, "Arial", clrAqua);
   
   // News-Filter Status anzeigen
   string newsFilterText = "News-Filter: ";
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
   ObjectSetText("Crypto_NewsFilter", newsFilterText, 10, "Arial", newsFilterColor);
}

//+------------------------------------------------------------------+
//| Trading-Statistiken ausgeben                                   |
//+------------------------------------------------------------------+
void PrintTradingStats()
{
   Print("=== CRYPTO TRADING STATISTIKEN ===");
   Print("Gesamte Trades: ", TotalTrades);
   Print("Gewinn-Trades: ", WinningTrades);
   Print("Verlust-Trades: ", LosingTrades);
   Print("Gesamt-Profit: ", DoubleToStr(TotalProfit, 2), " ", AccountCurrency());
   
   if(TotalTrades > 0)
   {
      double winRate = (WinningTrades * 100.0) / TotalTrades;
      Print("Win-Rate: ", DoubleToStr(winRate, 1), "%");
   }
   
   Print("==========================================");
}

//+------------------------------------------------------------------+
//| Timer function - Dashboard Updates bei geschlossenem Markt      |
//+------------------------------------------------------------------+
void OnTimer()
{
    if(EnableDashboard)
    {
        CheckTradeCount(); // Trade-Counter aktualisieren
        CalculatedLotSize = CalculateDynamicLotSize(); // Lot-Size berechnen
        UpdateCryptoDashboard(); // Dashboard aktualisieren
    }
}

//+------------------------------------------------------------------+
//| Ende des Krypto Expert Advisors                                |
//+------------------------------------------------------------------+