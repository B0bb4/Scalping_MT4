# ScalpingEA - Setup & Test Anleitung
*by Alexander Boß* | 🌐 [www.b0ss.dev](https://www.b0ss.dev)

## 🚀 Erste Schritte für den Test

### 1. Installation
1. **Gewünschte Version** in den Ordner `MQL4/Experts/` kopieren:
   - **ScalpingEA.mq4** (Forex-Version)
   - **ScalpingEA_Crypto.mq4** (Krypto-Version)
2. MetaTrader 4 neu starten
3. EA im Navigator unter "Expert Advisors" finden

### 💎 Welche Version wählen?

#### **💱 ScalpingEA.mq4** - FOREX EDITION
- ✅ **Optimiert für:** EURUSD, GBPUSD, USDJPY, AUDUSD, etc.
- ✅ **Spreads:** Pips-basierte Kalkulation (0.1-5 Pips)
- ✅ **Lot-Size:** 0.01 Standard (für 1:50-75 Hebel optimiert)
- ✅ **Take-Profit:** 60 Pips (RRR 2:1)
- ✅ **Volatilitäts-Filter:** 0.2% (professionell)
- ✅ **Magic Number:** 54321

#### **💎 ScalpingEA_Crypto.mq4** - CRYPTO EDITION
- ✅ **Optimiert für:** BTCUSD, ETHUSDT, SOLUSDT, etc.
- ✅ **Spreads:** Prozent-basierte Kalkulation (0.01-0.5%)
- ✅ **Lot-Size:** 0.005 Standard (Krypto-angepasst)
- ✅ **Take-Profit:** 1000-1500 Points (RRR 2.5)
- ✅ **Volatilitäts-Filter:** 2% (Krypto-angepasst)
- ✅ **Magic Number:** 12345

### 🎯 **BEIDE VERSIONEN HABEN IDENTISCHE FEATURES:**
- ✅ **Keine Trading-Beschränkungen** (nur Dashboard-Info)
- ✅ **Max. 3 Trades/Tag** (Empfehlung, kein Stopp)
- ✅ **Dashboard auch bei geschlossenem Markt**
- ✅ **News-Filter ein-/ausschaltbar**
- ✅ **Alle Symbole unterstützt**

## 🎯 NEUE FEATURES - Visuelle Signale & Tracking

### Automatische Chart-Signale:
- **🟢 Grüne Pfeile nach OBEN** = BUY Signal
- **🔴 Rote Pfeile nach UNTEN** = SELL Signal
- **❌ Exit-Pfeile** = Ausstieg aus Position
- **✅ Grüne Häkchen** = Gewinn-Trade
- **❌ Rote X** = Verlust-Trade
- **Profit-Anzeige** = Gewinn/Verlust neben jedem Trade

### Sound-System:
- **Entry-Sound** = Bei neuen Signalen
- **Exit-Sound** = Bei Trade-Ausstieg
- **Gewinn-Sound** = Bei erfolgreichem Trade
- **Verlust-Sound** = Bei Verlust-Trade

### Live-Dashboard zeigt:
- Trend-Richtung mit Pfeilen ⬆⬇
- Setup-Status (BULLISH/BEARISH/WAITING)
- Trading-Statistiken (Anzahl Trades, Gewinn/Verlust)
- **Live Win-Rate** in Prozent
- **Gesamt-Profit** in Echtzeit

### 2. Empfohlene Test-Einstellungen

**Für DEMO/Test (sicher):**
```
LotSize = 0.01                    // Kleinste Lot-Größe
RiskRewardRatio = 2.0            // Konservativ
EnableAlerts = true              // Alle Alerts an
EnableSounds = true              // Sound-Feedback
EnableDashboard = true           // Dashboard anzeigen

// NEUE Visuelle Einstellungen:
ShowEntryArrows = true           // Entry-Pfeile anzeigen
ShowExitArrows = true            // Exit-Pfeile anzeigen
ShowSuccessSymbols = true        // Erfolgs-Symbole anzeigen
SoundFileEntry = "alert.wav"     // Sound für Einstieg
SoundFileExit = "alert2.wav"     // Sound für Ausstieg
SoundFileWin = "ok.wav"          // Sound für Gewinn
SoundFileLoss = "timeout.wav"    // Sound für Verlust
```

**Stop Loss & Take Profit:**
```
UseATR_SL = true                 // ATR-basierte SL empfohlen
ATR_Multiplier = 2.0             // Konservativ
SL_Points = 200                  // Fallback SL
TP_Points = 400                  // Fallback TP
```

**Timeframe-Empfehlungen:**
- M5 (5 Minuten) - Für häufige Signale
- M15 (15 Minuten) - Für stabilere Signale

### 3. Vor dem ersten Start

#### ✅ Checklist:
- [ ] **Demo-Account verwenden** (niemals Live beim ersten Test!)
- [ ] **AutoTrading aktivieren** (Grüner Button in MT4)
- [ ] **Genügend freie Margin** (mindestens 100€ für 0.01 Lots)
- [ ] **Internetverbindung stabil**
- [ ] **EA-Parameter geprüft**

#### ⚠️ Wichtige Einstellungen in MT4:
1. **Rechtsklick auf Chart → "Expert Advisors" → "Eigenschaften"**
2. **"Gemeinsam" Tab:**
   - ✅ "Live-Handel erlauben"
   - ✅ "DLL-Importe erlauben" 
   - ✅ "Externe Expertenimporte erlauben"

### 4. Optimale Marktbedingungen für Tests

**Beste Handelszeiten:**
- **London Session:** 08:00 - 12:00 MEZ
- **New York Session:** 14:00 - 18:00 MEZ
- **Overlap:** 14:00 - 17:00 MEZ (höchste Volatilität)

**Empfohlene Währungspaare:**
- EURUSD (niedrigste Spreads)
- GBPUSD (gute Volatilität)
- USDJPY (klare Trends)

### 5. Monitoring & Erste Tests

#### Dashboard-Anzeige:
Das EA zeigt links oben ein Dashboard mit:
- Aktueller Trend-Richtung
- Volume-Status
- Setup-Status (BULLISH/BEARISH/WAITING)
- Support/Resistance Levels
- Position-Status

#### Was beim ersten Start passiert:
1. EA analysiert letzten 100 Kerzen
2. Identifiziert Support/Resistance
3. Berechnet Trend-Richtung
4. Wartet auf Setup-Bildung
5. Erste Signale nach 5-20 Minuten möglich

#### 🎯 Neue Signal-Erkennung:
**Einstieg-Signale:**
- 🟢 **Grüner Pfeil nach OBEN** + "BUY" Text = Kaufsignal
- 🔴 **Roter Pfeil nach UNTEN** + "SELL" Text = Verkaufssignal
- 🔊 **Entry-Sound** spielt automatisch ab
- 📢 **Popup-Alert** mit Einstiegspreis

**Ausstieg-Signale:**
- ❌ **X-Symbol** = Position wird geschlossen
- 🔊 **Exit-Sound** bei Positionsschluss
- 📢 **Alert** mit Ausstiegsgrund (z.B. "RSI Überkauft")

**Erfolgs-Tracking:**
- ✅ **Grünes Häkchen** + Profit-Betrag = Gewinn-Trade
- ❌ **Rotes X** + Verlust-Betrag = Verlust-Trade
- 🔊 **Gewinn/Verlust-Sound** je nach Ergebnis

### 6. Troubleshooting

**Wenn EA nicht handelt:**
- Prüfen: AutoTrading aktiviert?
- Prüfen: Genügend freie Margin?
- Prüfen: Trading-Zeiten (08:00-22:00 Uhr)?
- Prüfen: Alerts im Journal?

**Wenn zu viele/wenige Signale:**
- `VolumeMultiplier` anpassen (1.2-2.0)
- `SwingPeriod` ändern (15-30)
- `RiskRewardRatio` anpassen

### 7. Empfohlene Parameter für verschiedene Stile

#### Konservativ (weniger Trades, höhere Trefferquote):
```
VolumeMultiplier = 2.0
SwingPeriod = 30
RiskRewardRatio = 3.0
ATR_Multiplier = 2.5
```

#### Aggressiv (mehr Trades, höheres Risiko):
```
VolumeMultiplier = 1.2
SwingPeriod = 15
RiskRewardRatio = 1.5
ATR_Multiplier = 1.5
```

#### Balanced (Standard):
```
VolumeMultiplier = 1.5
SwingPeriod = 20
RiskRewardRatio = 2.0
ATR_Multiplier = 2.0
```

### 8. Wichtige Hinweise

⚠️ **NIEMALS ohne Test auf Live-Account!**
⚠️ **Immer mit Demo-Account beginnen**
⚠️ **Erst nach 1-2 Wochen erfolgreichen Tests auf Live**

📈 **Erfolgsmessung:**
- Mindestens 50 Trades für statistisch relevante Daten
- Profit Factor > 1.3 als Ziel
- Maximum Drawdown < 20%
- Win Rate > 60% anstreben

## 🎯 NEUE Dashboard-Features

**Live-Tracking im Dashboard:**
- **Setup-Status**: BULLISH ⬆ / BEARISH ⬇ / WAITING mit Farben
- **Trading-Statistiken**: Anzahl Trades, Gewinn/Verlust
- **Live Win-Rate**: Prozent-Anzeige in Echtzeit
- **Gesamt-Profit**: Aktueller Gewinn/Verlust
- **Position-Status**:
  - 🔄 "POSITION OPEN - MONITORING EXIT" (wartet auf Ausstieg)
  - 📈 "POSITION OPEN" (normale Position)
  - ⏳ "WAITING FOR SIGNAL" (wartet auf Signal)

**Automatische Exit-Bedingungen:**
- RSI Überkauft/Überverkauft
- Gegenteilige Trend-Signale
- Bearish Setup bei offener BUY Position
- Bullish Setup bei offener SELL Position

**Sound-Dateien** (Standard MT4 Sounds):
- `alert.wav` - Entry-Signal
- `alert2.wav` - Exit-Signal
- `ok.wav` - Gewinn-Trade
- `timeout.wav` - Verlust-Trade

## 🔧 **Parameter-Anpassungen**

Für detaillierte Informationen zu allen einstellbaren Parametern siehe:
📚 **[Funktions.md](Funktions.md)** - Vollständige Parameter-Referenz auf Deutsch

### **📋 Schnell-Referenz:**

#### **💰 Für mehr Trades:**
```
VolumeMultiplier = 1.2
SwingPeriod = 15
MaxTradesPerDay = 5
```

#### **🛡️ Für sicherere Trades:**
```
VolumeMultiplier = 2.5
SwingPeriod = 25
ATR_Multiplier = 3.5
```

#### **⚖️ Ausgewogen (Standard):**
```
VolumeMultiplier = 1.8
SwingPeriod = 20
RiskRewardRatio = 2.0
```

**Vollständige Details:** Siehe Funktions.md für alle Parameter und deren Auswirkungen.

---

### 9. Support & Anpassungen

Der EA ist vollständig konfigurierbar. Bei Fragen oder gewünschten Anpassungen können alle Parameter im EA-Header angepasst werden.

🌐 **Mehr Informationen:** [www.b0ss.dev](https://www.b0ss.dev)

**Viel Erfolg beim Trading!** 🚀