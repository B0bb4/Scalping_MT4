# ScalpingEA - Funktions & Parameter Referenz
*by Alexander Boß* | 🌐 [www.b0ss.dev](https://www.b0ss.dev)

## 🎯 Alle einstellbaren Parameter - BEIDE VERSIONEN

### 📋 Übersicht
**Zwei Versionen verfügbar:**
- 💱 **ScalpingEA.mq4** (Forex Edition)
- 💎 **ScalpingEA_Crypto.mq4** (Crypto Edition)

Beide Expert Advisors sind vollständig anpassbar. Alle Parameter können in den EA-Einstellungen (F7) verändert werden, ohne Programmier-Kenntnisse.

### 🔄 **Hauptunterschiede zwischen den Versionen:**

| Parameter | Forex-Version | Crypto-Version |
|-----------|---------------|----------------|
| **Standard Lot-Size** | 0.01 | 0.005 |
| **Spread-Einheit** | Pips (0.5-5) | Prozent (0.01-0.5%) |
| **Take Profit** | 50-75 Pips | 1000-1500 Points |
| **Volatilitäts-Filter** | 1% | 2% |
| **Magic Number** | 54321 | 12345 |
| **Optimiert für** | EURUSD, GBPUSD | BTCUSD, ETHUSDT |

**Alle anderen Parameter sind identisch!**

---

## 🔧 GRUNDEINSTELLUNGEN

### **LotSize** *(Standard: 0.005)*
**Was es ist:** Positionsgröße pro Trade  
**Auswirkung:** Höher = mehr Gewinn UND Verlust  
**Empfehlung:** Start mit 0.01, später bis 0.05  
**Achtung:** Zu hoch kann Konto zerstören!

### **RiskPercent** *(Standard: 1.0)*
**Was es ist:** Risiko pro Trade in Prozent vom Konto  
**Auswirkung:** Automatische Lot-Größen-Berechnung  
**Empfehlung:** 1-3% je nach Erfahrung  
**Hinweis:** Überschreibt LotSize wenn dynamische Berechnung aktiv

### **AccountBalance** *(Standard: 500.0)*
**Was es ist:** Referenz-Kontostand für Berechnungen  
**Auswirkung:** Basis für Risiko-Kalkulation  
**Empfehlung:** Auf echte Kontogröße setzen  
**Automatisch:** Wird vom EA erkannt falls nicht gesetzt

### **MaxTradesPerDay** *(Standard: 3)*
**Was es ist:** Maximale Anzahl Trades pro Tag  
**Auswirkung:** EA stoppt nach Erreichen des Limits  
**Empfehlung:** 2-5 je nach Strategie  
**Kundenprofil:** Optimiert für 2-3 hochwertige Trades

### **RiskRewardRatio** *(Standard: 2.5)*
**Was es ist:** Gewinn zu Verlust Verhältnis  
**Auswirkung:** 2.5 = 2,5x mehr Gewinn als Risiko  
**Empfehlung:** 1.5-3.0 je nach Erfahrung  
**Höher:** Weniger Trades, aber größere Gewinne

---

## ⏰ HANDELSZEITEN

### **RestrictedTradingHours** *(Standard: true)*
**Was es ist:** Begrenzte Handelszeiten aktivieren  
**Auswirkung:** EA handelt nur in festgelegten Zeiten  
**Kundenprofil:** Optimiert für 15:45-17:45 deutsche Zeit

### **TradingStartHour/Minute** *(Standard: 15:45)*
**Was es ist:** Täglicher Handelsbeginn  
**Auswirkung:** EA startet Trading erst ab dieser Zeit  
**Kundenprofil:** 15:45 für NY Pre-Market Phase

### **TradingEndHour/Minute** *(Standard: 17:45)*
**Was es ist:** Tägliches Handelsende  
**Auswirkung:** EA stoppt Trading nach dieser Zeit  
**Kundenprofil:** 17:45 nach NY Open Phase

### **NYOpenFocus** *(Standard: true)*
**Was es ist:** Verstärkte Aktivität um NY Open  
**Auswirkung:** Aggressivere Strategie um 15:30  
**Bonus:** Größere Lot-Sizes und erweiterte TPs

### **SundayTradingOnly** *(Standard: true)*
**Was es ist:** Am Wochenende nur Sonntag handeln  
**Auswirkung:** Samstag komplett gesperrt  
**Kundenprofil:** Reduziert Wochenend-Risiken

---

## 📊 SIGNAL-EINSTELLUNGEN

### **VolumeMultiplier** *(Standard: 2.5)*
**Was es ist:** Wie stark Volume ansteigen muss für Signal  
**Auswirkung:** Niedriger = mehr Signale, höher = weniger aber stärkere  
**Anpassung:**
- `1.2` = Viele Trades (8-15/Tag)
- `2.5` = Wenige, starke Trades (2-5/Tag)
- `3.0` = Sehr selektiv

### **SwingPeriod** *(Standard: 15)*
**Was es ist:** Zeitraum für Wendepunkt-Suche  
**Auswirkung:** Niedriger = reaktiver, höher = stabiler  
**Anpassung:**
- `15` = Schnelle Reaktion (mehr Signale)
- `25` = Stabile Signale (weniger Fehlsignale)
- `30` = Sehr konservativ

### **BreakoutThreshold** *(Standard: 0.002)*
**Was es ist:** Mindest-Bewegung für Breakout-Signal  
**Auswirkung:** 0.2% Preisbewegung nötig  
**Krypto-optimiert:** Höhere Schwelle wegen Volatilität

---

## 🛡️ RISIKOMANAGEMENT

### **MaxDrawdownPercent** *(Standard: 2.0)*
**Was es ist:** Maximaler erlaubter Drawdown  
**Auswirkung:** EA stoppt bei Überschreitung  
**Kundenprofil:** Strenge 2% Grenze  
**Schutz:** Automatischer Trading-Stop

### **UseATR_SL** *(Standard: true)*
**Was es ist:** Automatische Stop Loss Anpassung  
**Auswirkung:** EA passt SL an Marktvolatilität an  
**WICHTIG:** Niemals auf false setzen!  
**Vorteil:** Weniger Ausstoppungen

### **ATR_Multiplier** *(Standard: 3.0)*
**Was es ist:** Faktor für Stop Loss Entfernung  
**Auswirkung:** Höher = weitere Stops, weniger Ausstoppungen  
**Anpassung:**
- `2.0` = Enge Stops (mehr Ausstoppungen)
- `3.0` = Standard (ausgewogen)
- `4.0` = Weite Stops (größere Verluste möglich)

### **TrailingDistance** *(Standard: 250)*
**Was es ist:** Abstand für Trailing Stop  
**Auswirkung:** Wie nah der Stop dem Preis folgt  
**Funktion:** Sichert Gewinne bei Trendumkehr

---

## 📰 NEWS & FILTER

### **NewsFilter** *(Standard: false)*
**Was es ist:** Trading bei wichtigen News pausieren  
**Auswirkung:** Schutz vor News-Volatilität  
**Zeiten:**
- FOMC: Mittwoch 20:00 deutsche Zeit
- CPI: Dienstag/Donnerstag 14:30 deutsche Zeit
**Dashboard:** Zeigt Status live an

### **AvoidFOMC** *(Standard: true)*
**Was es ist:** Fed-Meetings meiden  
**Auswirkung:** Kein Trading während Fed-Sitzungen  
**Nur aktiv wenn:** NewsFilter = true

### **AvoidCPI** *(Standard: true)*
**Was es ist:** Inflationsdaten meiden  
**Auswirkung:** Kein Trading bei CPI-Veröffentlichungen  
**Nur aktiv wenn:** NewsFilter = true

---

## 📈 TAKE PROFIT & STOP LOSS

### **SL_Points** *(Standard: 400)*
**Was es ist:** Fallback Stop Loss in Points  
**Auswirkung:** Wird nur verwendet wenn ATR versagt  
**Empfehlung:** UseATR_SL = true verwenden

### **TP_Points** *(Standard: 1000)*
**Was es ist:** Erstes Take Profit Level  
**Auswirkung:** Primäres Gewinnziel  
**Kundenprofil:** Optimiert für höhere Gewinne

### **TP2_Points** *(Standard: 1500)*
**Was es ist:** Zweites Take Profit Level  
**Auswirkung:** Erweiterte Gewinnmöglichkeiten  
**Funktion:** Für starke Trends

---

## 🔊 ALERTS & INTERFACE

### **EnableAlerts** *(Standard: true)*
**Was es ist:** Popup-Nachrichten aktivieren  
**Auswirkung:** Wichtige Ereignisse werden angezeigt  
**Empfehlung:** Immer auf true lassen

### **EnableSounds** *(Standard: true)*
**Was es ist:** Sound-Benachrichtigungen  
**Auswirkung:** Akustische Signale bei Events  
**Sounds:**
- Entry: `alert.wav`
- Exit: `alert2.wav`
- Gewinn: `ok.wav`
- Verlust: `timeout.wav`

### **EnableDashboard** *(Standard: true)*
**Was es ist:** Live-Dashboard anzeigen  
**Auswirkung:** Informationen links oben im Chart  
**Inhalt:** Status, Statistiken, Trades, Zeiten

---

## 🎨 VISUELLE EINSTELLUNGEN

### **ShowEntryArrows** *(Standard: true)*
**Was es ist:** Einstiegs-Pfeile im Chart  
**Darstellung:**
- 🟢 Grüner Pfeil nach oben = BUY
- 🔴 Roter Pfeil nach unten = SELL

### **ShowExitArrows** *(Standard: true)*
**Was es ist:** Ausstiegs-Pfeile im Chart  
**Darstellung:** ❌ X-Symbol bei Positionsschluss

### **ShowSuccessSymbols** *(Standard: true)*
**Was es ist:** Erfolgs-Symbole nach Trades  
**Darstellung:**
- ✅ Grünes Häkchen + Profit = Gewinn
- ❌ Rotes X + Verlust = Verlust

### **ShowVolatilityZones** *(Standard: true)*
**Was es ist:** Volatilitäts-Bereiche markieren  
**Funktion:** Zeigt extreme Volume-Spikes

---

## 🔢 TECHNISCHE INDIKATOREN

### **RSI_Period** *(Standard: 12)*
**Was es ist:** Periode für RSI-Indikator  
**Auswirkung:** Kürzere Periode = reaktiver  
**Nur ändern wenn:** Sie RSI verstehen

### **RSI_Overbought/Oversold** *(Standard: 75/25)*
**Was es ist:** Überkauft/Überverkauft Levels  
**Krypto-optimiert:** Erweiterte Bereiche  
**Auswirkung:** Exit-Signale

### **EMA_Fast/Medium/Slow** *(Standard: 8/18/42)*
**Was es ist:** Gleitende Durchschnitte  
**Funktion:** Trend-Erkennung  
**Nur für:** Erfahrene Trader

---

## ⚙️ KRYPTO-SPEZIFISCHE PARAMETER

### **CryptoMode** *(Standard: true)*
**Was es ist:** Krypto-Optimierungen aktivieren  
**Auswirkung:** Höhere Volatilitäts-Toleranz  
**Features:** 24/7 Trading, angepasste Indikatoren

### **MinSpread/MaxSpread** *(Standard: 0.0001/0.005)*
**Was es ist:** Spread-Grenzen für Trading  
**Auswirkung:** Kein Trading bei zu hohen Spreads  
**Schutz:** Vor schlechten Ausführungen

### **VolatilityFilter** *(Standard: 0.02)*
**Was es ist:** Volatilitäts-Filter (2%)  
**Auswirkung:** Kein Trading bei extremer Volatilität  
**Krypto:** Wichtig wegen häufiger Spikes

---

# 📋 SCHNELL-REFERENZ

## 🚀 FÜR MEHR TRADES:
```
VolumeMultiplier = 1.2
SwingPeriod = 15
MaxTradesPerDay = 5
```

## 🛡️ FÜR SICHERERE TRADES:
```
VolumeMultiplier = 2.5
SwingPeriod = 25
ATR_Multiplier = 3.5
MaxDrawdownPercent = 1.5
```

## 💰 FÜR HÖHERE GEWINNE:
```
RiskRewardRatio = 3.0
TP_Points = 1500
NYOpenFocus = true
```

## ⏰ FÜR BESTIMMTE ZEITEN:
```
RestrictedTradingHours = true
TradingStartHour = 15
TradingEndHour = 17
NewsFilter = true
```

---

## ❌ NIEMALS ÄNDERN:
- `MagicNumber` = EA erkennt seine Trades daran
- `UseATR_SL` = Immer auf true lassen
- `EnableAlerts` = Sonst verpassen Sie Signale

## ⚠️ NUR MIT ERFAHRUNG:
- RSI, MACD, EMA Parameter
- Spread-Einstellungen
- Volatilitäts-Filter

---

🌐 **Support:** [www.b0ss.dev](https://www.b0ss.dev)  
📚 **Setup-Anleitung:** Siehe EA_Setup_Anleitung.md  
🔧 **Installation:** Siehe EA_Setup_Guide_EN.md