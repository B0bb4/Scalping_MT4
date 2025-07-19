# 🚀 ScalpingEA Professionelles Trading System

[![Lizenz](https://img.shields.io/badge/lizenz-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.25-green.svg)](CHANGELOG.md)
[![Plattform](https://img.shields.io/badge/plattform-MetaTrader%204-orange.svg)](https://www.metatrader4.com/)
[![Sprache](https://img.shields.io/badge/sprache-MQL4-red.svg)](https://docs.mql4.com/)

> **Professioneller Expert Advisor für Hochfrequenz-Trading optimiert für 1:50-75 Hebel**

## 📋 Überblick

ScalpingEA ist ein ausgeklügelter Expert Advisor für professionelle Trader, die konsistente, hochwertige Trades mit minimalem Drawdown suchen. Das System ist für 2-3 Premium-Trades pro Tag optimiert mit Fokus auf die NY-Markt-Eröffnung und hält strenge Risikomanagement-Protokolle ein.

### 🎯 Hauptmerkmale

- **📊 Dual-Versions-System**: Separate Optimierungen für Forex- und Kryptowährungsmärkte
- **🎯 Qualität statt Quantität**: 2-3 hochwahrscheinliche Trades pro Tag
- **⚖️ Erweiterte Risikokontrolle**: Maximum 1-2% Drawdown pro Trade
- **🕐 NY Open Fokus**: Optimiert für 9:30 Uhr NY-Zeit (15:30 deutsche Zeit)
- **📈 Hohes Risk-Reward-Verhältnis**: 2,5:1 RRR für maximale Profitabilität
- **🎨 Professionelles Chart-Design**: Benutzerdefinierte visuelle Indikatoren und Styling
- **🔄 Keine Trading-Beschränkungen**: Vollständige Freiheit mit nur informativen Dashboard

---

## 📦 Paketinhalt

### 💱 Forex Edition (`ScalpingEA.mq4`)
- **Optimiert für**: EURUSD, GBPUSD, USDJPY, AUDUSD
- **Hebel**: 1:50-75 optimiert
- **Lot-Größe**: 0,01 Standard
- **Take Profit**: 60 Pips (RRR 2:1)
- **Spreads**: 0,1-5 Pips Toleranz
- **Magic Number**: 54321

### 💎 Krypto Edition (`ScalpingEA_Crypto.mq4`)
- **Optimiert für**: BTCUSD, ETHUSDT, SOLUSDT, XRPUSDT
- **Hebel**: 1:50-75 optimiert
- **Lot-Größe**: 0,01 Standard
- **Take Profit**: 1000-1500 Punkte
- **Spreads**: 0,01-0,5% Toleranz
- **Magic Number**: 12345

---

## 🚀 Schnellstart

### 1. Installation
```bash
# 1. Repository herunterladen
git clone https://github.com/yourusername/ScalpingEA.git

# 2. In MetaTrader 4 kopieren
cp ScalpingEA*.mq4 "C:/Program Files/MetaTrader 4/MQL4/Experts/"

# 3. MetaTrader 4 neustarten
# 4. EA im Navigator > Expert Advisors finden
```

### 2. Konfiguration
1. **Version wählen** (Forex oder Krypto)
2. **An Chart anhängen** (M5 Zeitrahmen empfohlen)
3. **Auto Trading aktivieren** (F7 → Live-Trading erlauben)
4. **Dashboard überwachen** für Echtzeit-Statistiken

---

## ⚙️ Wichtige Parameter

### 📊 Kern-Einstellungen
| Parameter | Forex | Krypto | Beschreibung |
|-----------|-------|--------|--------------|
| `LotSize` | 0,01 | 0,01 | Standard Lot-Größe (1:50-75 Hebel optimiert) |
| `RiskPercent` | 1,0% | 1,0% | Risiko pro Trade |
| `AccountBalance` | 1000,0 | 1000,0 | Referenz-Kontostand |
| `MaxTradesPerDay` | 3 | 3 | Maximum Trades pro Tag (Empfehlung) |
| `RiskRewardRatio` | 2,5 | 2,5 | Risk-Reward-Verhältnis |

### 🕐 Handelszeiten
| Einstellung | Wert | Beschreibung |
|-------------|------|--------------|
| `TradingStartHour` | 15 | 15:45 deutsche Zeit |
| `TradingStartMinute` | 45 | Start-Minute |
| `TradingEndHour` | 17 | 17:45 deutsche Zeit |
| `TradingEndMinute` | 45 | End-Minute |
| `NYOpenFocus` | true | NY Open Optimierung (15:30 deutsche Zeit) |

---

## 📈 Performance-Features

### 🎯 Professionelle Trading-Logik
- **Intelligente Einstiegssignale**: Multi-Timeframe-Analyse mit Volume-Bestätigung
- **ATR-basierte Stop-Loss**: Dynamisches Risikomanagement basierend auf Marktvolatilität
- **Trend-Following**: EMA-Crossover mit Momentum-Bestätigung
- **Volume-Analyse**: Hochvolumen-Breakout-Erkennung
- **News-Filter**: Optionale Nachrichtenereignis-Vermeidung

### 📊 Visuelle Indikatoren
- **🟢 Grüne Pfeile**: KAUF-Signale
- **🔴 Rote Pfeile**: VERKAUF-Signale
- **❌ Ausstiegspfeile**: Positions-Ausstiege
- **✅ Erfolgs-Markierungen**: Gewinn-Trades
- **❌ Verlust-Markierungen**: Verlust-Trades

### 🎨 Professionelles Chart-Styling
- **Neon-Grün**: Bullische Kerzen
- **Hot Pink**: Bärische Kerzen
- **Deep Sky Blue**: Bid-Linie
- **Hot Pink**: Ask-Linie
- **Dunkles Theme**: Professionelles Erscheinungsbild

---

## 🛡️ Risikomanagement

### ⚖️ Erweiterte Absicherung
- **Maximaler Drawdown**: 2% Limit
- **Positionsgrößen-Berechnung**: Dynamische Lot-Kalkulation
- **Spread-Schutz**: Automatische Spread-Filterung
- **Volatilitäts-Filter**: Marktkonditionen-Bewertung
- **Trailing Stop**: Gewinn-Schutz-Mechanismus

### 📊 Echtzeit-Überwachung
- **Live-Dashboard**: Wichtige Metriken-Anzeige
- **Trade-Statistiken**: Win-Rate, Profit-Faktor
- **Risiko-Metriken**: Aktueller Drawdown, Exposure
- **Markt-Status**: Trading-Konditionen-Bewertung

---

## 🔧 Erweiterte Konfiguration

### 📋 Filter-Einstellungen
```mql4
// Volume & Breakout Einstellungen
extern double VolumeMultiplier = 1.5;      // Volume-Spike-Erkennung
extern double BreakoutThreshold = 0.0015;  // Minimum Breakout-Größe (0,15%)
extern double VolatilityFilter = 0.002;    // Volatilitäts-Anforderung (0,2%)

// Technische Indikatoren
extern int RSI_Period = 12;                // RSI-Periode
extern double RSI_Overbought = 75;         // Überkauft-Level
extern double RSI_Oversold = 25;           // Überverkauft-Level
```

### 🎛️ Anpassungsoptionen
```mql4
// Visuelle Einstellungen
extern bool ShowEntryArrows = true;        // Einstiegssignale anzeigen
extern bool ShowExitArrows = true;         // Ausstiegssignale anzeigen
extern bool ShowSuccessSymbols = true;     // Trade-Ergebnisse zeigen
extern bool EnableDashboard = true;        // Echtzeit-Dashboard

// Alert-Einstellungen
extern bool EnableAlerts = true;           // Popup-Alerts
extern bool EnableSounds = true;           // Sound-Benachrichtigungen
extern string SoundFileEntry = "alert.wav"; // Einstiegs-Sound
extern string SoundFileExit = "alert2.wav"; // Ausstiegs-Sound
```

---

## 📚 Dokumentation

### 📖 Vollständige Anleitungen
- **[Setup-Anleitung](EA_Setup_Anleitung.md)**: Detaillierte Installationsanweisungen
- **[Parameter-Referenz](Funktions.md)**: Vollständige Parameter-Dokumentation
- **[English Documentation](EA_Setup_Guide_EN.md)**: English Instructions

---

## 🏆 Versionshistorie

### Version 2.25 (Aktuell)
- ✅ **Hebel-Optimierung**: Optimiert für 1:50-75 Hebel
- ✅ **Parameter-Harmonisierung**: Konsistente Einstellungen zwischen Versionen
- ✅ **Professionelle Standards**: Produktionsreife Konfiguration
- ✅ **Dokumentations-Sync**: Code und Dokumentation abgestimmt
- ✅ **Verbessertes Dashboard**: Echtzeit-Marktinformationen
- ✅ **Universelle Symbol-Unterstützung**: Keine Trading-Beschränkungen

### Frühere Versionen
- **v2.24**: Verbesserte visuelle Indikatoren und Chart-Styling
- **v2.23**: Verbessertes Risikomanagement und Drawdown-Kontrolle
- **v2.22**: NY Open Fokus und Trading-Zeit-Optimierung hinzugefügt
- **v2.21**: Dual-Versions-System implementiert (Forex/Krypto)

---

## 🤝 Mitwirken

Wir begrüßen Beiträge! Bitte lesen Sie unsere [Mitwirkungs-Richtlinien](CONTRIBUTING.md) für Details.

### 📋 Entwicklungs-Workflow
1. Repository forken
2. Feature-Branch erstellen
3. Änderungen mit Tests implementieren
4. Pull Request einreichen
5. Code-Review abwarten

---

## 📄 Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert - siehe [LICENSE](LICENSE) Datei für Details.

---

## ⚠️ Haftungsausschluss

**Der Handel mit Finanzinstrumenten birgt erhebliche Risiken und ist möglicherweise nicht für alle Anleger geeignet. Die Wertentwicklung der Vergangenheit garantiert keine zukünftigen Ergebnisse. Bitte handeln Sie verantwortungsbewusst und riskieren Sie niemals mehr, als Sie sich leisten können zu verlieren.**

---

<div align="center">

**Mit ❤️ erstellt von [Alexander Boß](https://www.b0ss.dev)**

*Professionelle Trading-Lösungen für den modernen Trader*

</div>