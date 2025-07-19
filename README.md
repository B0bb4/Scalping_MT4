# 🚀 ScalpingEA Professional Trading System

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.25-green.svg)](CHANGELOG.md)
[![Platform](https://img.shields.io/badge/platform-MetaTrader%204-orange.svg)](https://www.metatrader4.com/)
[![Language](https://img.shields.io/badge/language-MQL4-red.svg)](https://docs.mql4.com/)

> **Professional Expert Advisor for high-frequency trading optimized for 1:50-75 leverage**

## 📋 Overview

ScalpingEA is a sophisticated Expert Advisor designed for professional traders seeking consistent, high-quality trades with minimal drawdown. The system is optimized for 2-3 premium trades per day with a focus on the NY market opening and maintains strict risk management protocols.

### 🎯 Key Features

- **📊 Dual Version System**: Separate optimizations for Forex and Cryptocurrency markets
- **🎯 Quality over Quantity**: 2-3 high-probability trades per day
- **⚖️ Advanced Risk Management**: Maximum 1-2% drawdown per trade
- **🕐 NY Open Focus**: Optimized for 9:30 AM NY time (3:30 PM German time)
- **📈 High Risk-Reward Ratio**: 2.5:1 RRR for maximum profitability
- **🎨 Professional Chart Design**: Custom visual indicators and styling
- **🔄 No Trading Restrictions**: Complete freedom with informational dashboard only

---

## 📦 Package Contents

### 💱 Forex Edition (`ScalpingEA.mq4`)
- **Optimized for**: EURUSD, GBPUSD, USDJPY, AUDUSD
- **Leverage**: 1:50-75 optimized
- **Lot Size**: 0.01 standard
- **Take Profit**: 60 pips (RRR 2:1)
- **Spreads**: 0.1-5 pips tolerance
- **Magic Number**: 54321

### 💎 Crypto Edition (`ScalpingEA_Crypto.mq4`)
- **Optimized for**: BTCUSD, ETHUSDT, SOLUSDT, XRPUSDT
- **Leverage**: 1:50-75 optimized
- **Lot Size**: 0.01 standard
- **Take Profit**: 1000-1500 points
- **Spreads**: 0.01-0.5% tolerance
- **Magic Number**: 12345

---

## 🚀 Quick Start

### 1. Installation
```bash
# 1. Download the repository
git clone https://github.com/yourusername/ScalpingEA.git

# 2. Copy to MetaTrader 4
cp ScalpingEA*.mq4 "C:/Program Files/MetaTrader 4/MQL4/Experts/"

# 3. Restart MetaTrader 4
# 4. Find EA in Navigator > Expert Advisors
```

### 2. Configuration
1. **Choose your version** (Forex or Crypto)
2. **Attach to chart** (M5 timeframe recommended)
3. **Enable Auto Trading** (F7 → Allow live trading)
4. **Monitor Dashboard** for real-time statistics

---

## ⚙️ Key Parameters

### 📊 Core Settings
| Parameter | Forex | Crypto | Description |
|-----------|-------|--------|-------------|
| `LotSize` | 0.01 | 0.01 | Standard lot size (1:50-75 leverage optimized) |
| `RiskPercent` | 1.0% | 1.0% | Risk per trade |
| `AccountBalance` | 1000.0 | 1000.0 | Reference balance |
| `MaxTradesPerDay` | 3 | 3 | Maximum trades per day (recommendation) |
| `RiskRewardRatio` | 2.5 | 2.5 | Risk-reward ratio |

### 🕐 Trading Hours
| Setting | Value | Description |
|---------|-------|-------------|
| `TradingStartHour` | 15 | 3:45 PM German time |
| `TradingStartMinute` | 45 | Start minute |
| `TradingEndHour` | 17 | 5:45 PM German time |
| `TradingEndMinute` | 45 | End minute |
| `NYOpenFocus` | true | NY Open optimization (3:30 PM German) |

---

## 📈 Performance Features

### 🎯 Professional Trading Logic
- **Smart Entry Signals**: Multi-timeframe analysis with volume confirmation
- **ATR-based Stop Loss**: Dynamic risk management based on market volatility
- **Trend Following**: EMA crossover with momentum confirmation
- **Volume Analysis**: High-volume breakout detection
- **News Filter**: Optional news event avoidance

### 📊 Visual Indicators
- **🟢 Green Arrows**: BUY signals
- **🔴 Red Arrows**: SELL signals
- **❌ Exit Arrows**: Position exits
- **✅ Success Markers**: Winning trades
- **❌ Loss Markers**: Losing trades

### 🎨 Professional Chart Styling
- **Neon Green**: Bullish candles
- **Hot Pink**: Bearish candles
- **Deep Sky Blue**: Bid line
- **Hot Pink**: Ask line
- **Dark Theme**: Professional appearance

---

## 🛡️ Risk Management

### ⚖️ Advanced Protection
- **Maximum Drawdown**: 2% limit
- **Position Sizing**: Dynamic lot calculation
- **Spread Protection**: Automatic spread filtering
- **Volatility Filter**: Market condition assessment
- **Trailing Stop**: Profit protection mechanism

### 📊 Real-time Monitoring
- **Live Dashboard**: Key metrics display
- **Trade Statistics**: Win rate, profit factor
- **Risk Metrics**: Current drawdown, exposure
- **Market Status**: Trading conditions assessment

---

## 🔧 Advanced Configuration

### 📋 Filter Settings
```mql4
// Volume & Breakout Settings
extern double VolumeMultiplier = 1.5;      // Volume spike detection
extern double BreakoutThreshold = 0.0015;  // Minimum breakout size (0.15%)
extern double VolatilityFilter = 0.002;    // Volatility requirement (0.2%)

// Technical Indicators
extern int RSI_Period = 12;                // RSI period
extern double RSI_Overbought = 75;         // Overbought level
extern double RSI_Oversold = 25;           // Oversold level
```

### 🎛️ Customization Options
```mql4
// Visual Settings
extern bool ShowEntryArrows = true;        // Display entry signals
extern bool ShowExitArrows = true;         // Display exit signals
extern bool ShowSuccessSymbols = true;     // Show trade results
extern bool EnableDashboard = true;        // Real-time dashboard

// Alert Settings
extern bool EnableAlerts = true;           // Popup alerts
extern bool EnableSounds = true;           // Sound notifications
extern string SoundFileEntry = "alert.wav"; // Entry sound
extern string SoundFileExit = "alert2.wav"; // Exit sound
```

---

## 📚 Documentation

### 📖 Complete Guides
- **[Setup Guide](EA_Setup_Guide_EN.md)**: Detailed installation instructions
- **[Parameter Reference](Functions.md)**: Complete parameter documentation
- **[German Documentation](EA_Setup_Anleitung.md)**: Deutsche Anleitung
- **[Trading Strategies](docs/strategies.md)**: Recommended approaches

### 🔧 Support Files
- **[Troubleshooting](docs/troubleshooting.md)**: Common issues and solutions
- **[Optimization Guide](docs/optimization.md)**: Performance tuning
- **[Backtest Results](docs/backtests.md)**: Historical performance data

---

## 🏆 Version History

### Version 2.25 (Current)
- ✅ **Leverage Optimization**: Optimized for 1:50-75 leverage
- ✅ **Parameter Harmonization**: Consistent settings across versions
- ✅ **Professional Defaults**: Production-ready configuration
- ✅ **Documentation Sync**: Aligned code and documentation
- ✅ **Enhanced Dashboard**: Real-time market information
- ✅ **Universal Symbol Support**: No trading restrictions

### Previous Versions
- **v2.24**: Enhanced visual indicators and chart styling
- **v2.23**: Improved risk management and drawdown control
- **v2.22**: Added NY Open focus and trading time optimization
- **v2.21**: Implemented dual-version system (Forex/Crypto)

---

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details.

### 📋 Development Workflow
1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit a pull request
5. Await code review

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Support

### 🌐 Contact
- **Website**: [www.b0ss.dev](https://www.b0ss.dev)
- **Author**: Alexander Boß
- **Email**: [contact@b0ss.dev](mailto:contact@b0ss.dev)
- **Issues**: [GitHub Issues](https://github.com/yourusername/ScalpingEA/issues)

### 💬 Community
- **Discord**: [Trading Community](https://discord.gg/trading)
- **Telegram**: [@ScalpingEA](https://t.me/ScalpingEA)
- **Twitter**: [@alexanderboss_](https://twitter.com/alexanderboss_)

---

## ⚠️ Disclaimer

**Trading financial instruments involves substantial risk and may not be suitable for all investors. Past performance does not guarantee future results. Please trade responsibly and never risk more than you can afford to lose.**

---

<div align="center">

**Made with ❤️ by [Alexander Boß](https://www.b0ss.dev)**

*Professional Trading Solutions for the Modern Trader*

</div>