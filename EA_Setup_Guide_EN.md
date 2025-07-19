# ScalpingEA - Setup & Test Guide
*by Alexander Boß* | 🌐 [www.b0ss.dev](https://www.b0ss.dev)

**Strategy by Greg Bieder** - Optimized for H1 timeframe with proven 40% win rate

## 🚀 Getting Started

### 1. Installation
1. **Copy desired version** to `MQL4/Experts/` folder:
   - **ScalpingEA.mq4** (Forex Version)
   - **ScalpingEA_Crypto.mq4** (Crypto Version)
2. Restart MetaTrader 4
3. Find EA in Navigator under "Expert Advisors"

### 💎 Which Version to Choose?

#### **💱 ScalpingEA.mq4** - FOREX EDITION (H1 OPTIMIZED)
- ✅ **Optimized for:** H1 timeframe (EURUSD proven)
- ✅ **Entry Logic:** RSI 50/50 + EMA50 confirmation
- ✅ **Exit Strategy:** 50 pips TP / 60 pips SL / RSI 75-25
- ✅ **Performance:** 40% win rate, +91 pips proven
- ✅ **Trading Frequency:** 10-12 trades/month (quality focus)
- ✅ **Magic Number:** 54321

#### **💎 ScalpingEA_Crypto.mq4** - CRYPTO EDITION
- ✅ **Optimized for:** BTCUSD, ETHUSDT, SOLUSDT, etc.
- ✅ **Spreads:** Percent-based calculation (0.01-0.5%)
- ✅ **Lot Size:** 0.01 Standard (optimized for 1:50-75 leverage)
- ✅ **Take Profit:** 1000-1500 Points (RRR 2.5)
- ✅ **Volatility Filter:** 2% (Crypto-adapted)
- ✅ **Magic Number:** 12345

### 🎯 **BOTH VERSIONS HAVE IDENTICAL FEATURES:**
- ✅ **No Trading Restrictions** (Dashboard info only)
- ✅ **Max 3 Trades/Day** (Recommendation, no stop)
- ✅ **Dashboard even when market closed**
- ✅ **News Filter on/off switchable**
- ✅ **All symbols supported**

## 🎯 NEW FEATURES - Visual Signals & Tracking

### Automatic Chart Signals:
- **🟢 Green Arrows UP** = BUY Signal
- **🔴 Red Arrows DOWN** = SELL Signal
- **❌ Exit Arrows** = Position Exit
- **✅ Green Checkmarks** = Winning Trade
- **❌ Red X** = Losing Trade
- **Profit Display** = Gain/Loss next to each trade

### Sound System:
- **Entry Sound** = On new signals
- **Exit Sound** = On trade exit
- **Win Sound** = On successful trade
- **Loss Sound** = On losing trade

### Live Dashboard Shows:
- Trend direction with arrows ⬆⬇
- Setup status (BULLISH/BEARISH/WAITING)
- Trading statistics (Number of trades, Win/Loss)
- **Live Win Rate** in percentage
- **Total Profit** in real-time

### 2. Recommended Test Settings

**For DEMO/Test (safe):**
```
LotSize = 0.01                    // Smallest lot size
RiskRewardRatio = 2.0            // Conservative
EnableAlerts = true              // All alerts on
EnableSounds = true              // Sound feedback
EnableDashboard = true           // Show dashboard

// NEW Visual Settings:
ShowEntryArrows = true           // Show entry arrows
ShowExitArrows = true            // Show exit arrows
ShowSuccessSymbols = true        // Show success symbols
SoundFileEntry = "alert.wav"     // Sound for entry
SoundFileExit = "alert2.wav"     // Sound for exit
SoundFileWin = "ok.wav"          // Sound for win
SoundFileLoss = "timeout.wav"    // Sound for loss
```

**Stop Loss & Take Profit:**
```
UseATR_SL = true                 // ATR-based SL recommended
ATR_Multiplier = 2.0             // Conservative
SL_Points = 200                  // Fallback SL
TP_Points = 400                  // Fallback TP
```

**Timeframe Recommendations:**
- M5 (5 minutes) - For frequent signals
- M15 (15 minutes) - For more stable signals

### 3. Before First Start

#### ✅ Checklist:
- [ ] **Use Demo Account** (never Live on first test!)
- [ ] **Enable AutoTrading** (Green button in MT4)
- [ ] **Sufficient free margin** (minimum $100 for 0.01 lots)
- [ ] **Stable internet connection**
- [ ] **EA parameters checked**

#### ⚠️ Important MT4 Settings:
1. **Right-click on Chart → "Expert Advisors" → "Properties"**
2. **"Common" Tab:**
   - ✅ "Allow live trading"
   - ✅ "Allow DLL imports"
   - ✅ "Allow imports of external experts"

### 4. Optimal Market Conditions for Testing

**Best Trading Hours:**
- **London Session:** 08:00 - 12:00 CET
- **New York Session:** 14:00 - 18:00 CET
- **Overlap:** 14:00 - 17:00 CET (highest volatility)

**Recommended Currency Pairs:**
- EURUSD (lowest spreads)
- GBPUSD (good volatility)
- USDJPY (clear trends)

### 5. Monitoring & First Tests

#### Dashboard Display:
The EA shows a dashboard in the top left with:
- Current trend direction
- Volume status
- Setup status (BULLISH/BEARISH/WAITING)
- Support/Resistance levels
- Position status

#### What happens on first start:
1. EA analyzes last 100 candles
2. Identifies Support/Resistance
3. Calculates trend direction
4. Waits for setup formation
5. First signals possible after 5-20 minutes

#### 🎯 New Signal Recognition:
**Entry Signals:**
- 🟢 **Green Arrow UP** + "BUY" text = Buy signal
- 🔴 **Red Arrow DOWN** + "SELL" text = Sell signal
- 🔊 **Entry Sound** plays automatically
- 📢 **Popup Alert** with entry price

**Exit Signals:**
- ❌ **X Symbol** = Position being closed
- 🔊 **Exit Sound** on position close
- 📢 **Alert** with exit reason (e.g., "RSI Overbought")

**Success Tracking:**
- ✅ **Green Checkmark** + Profit amount = Winning trade
- ❌ **Red X** + Loss amount = Losing trade
- 🔊 **Win/Loss Sound** depending on result

### 6. Troubleshooting

**If EA doesn't trade:**
- Check: AutoTrading enabled?
- Check: Sufficient free margin?
- Check: Trading hours (08:00-22:00)?
- Check: Alerts in Journal?

**If too many/few signals:**
- Adjust `VolumeMultiplier` (1.2-2.0)
- Change `SwingPeriod` (15-30)
- Adjust `RiskRewardRatio`

### 7. Recommended Parameters for Different Styles

#### Conservative (fewer trades, higher hit rate):
```
VolumeMultiplier = 2.0
SwingPeriod = 30
RiskRewardRatio = 3.0
ATR_Multiplier = 2.5
```

#### Aggressive (more trades, higher risk):
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

### 8. Important Notes

⚠️ **NEVER without testing on Live Account!**
⚠️ **Always start with Demo Account**
⚠️ **Only after 1-2 weeks of successful tests go Live**

📈 **Success Measurement:**
- Minimum 50 trades for statistically relevant data
- Profit Factor > 1.3 as target
- Maximum Drawdown < 20%
- Win Rate > 60% target

## 🎯 NEW Dashboard Features

**Live Tracking in Dashboard:**
- **Setup Status**: BULLISH ⬆ / BEARISH ⬇ / WAITING with colors
- **Trading Statistics**: Number of trades, Win/Loss
- **Live Win Rate**: Real-time percentage display
- **Total Profit**: Current gain/loss
- **Position Status**:
  - 🔄 "POSITION OPEN - MONITORING EXIT" (waiting for exit)
  - 📈 "POSITION OPEN" (normal position)
  - ⏳ "WAITING FOR SIGNAL" (waiting for signal)

**Automatic Exit Conditions:**
- RSI Overbought/Oversold
- Contrary trend signals
- Bearish setup closes BUY position
- Bullish setup closes SELL position

**Sound Files** (Standard MT4 Sounds):
- `alert.wav` - Entry signal
- `alert2.wav` - Exit signal
- `ok.wav` - Winning trade
- `timeout.wav` - Losing trade

## 🔧 **Parameter Adjustments**

For detailed information about all adjustable parameters see:
📚 **[Functions.md](Functions.md)** - Complete Parameter Reference in English

### **📋 Quick Reference:**

#### **💰 For more trades:**
```
VolumeMultiplier = 1.2
SwingPeriod = 15
MaxTradesPerDay = 5
```

#### **🛡️ For safer trades:**
```
VolumeMultiplier = 2.5
SwingPeriod = 25
ATR_Multiplier = 3.5
```

#### **⚖️ Balanced (Standard):**
```
VolumeMultiplier = 1.8
SwingPeriod = 20
RiskRewardRatio = 2.0
```

**Full Details:** See Functions.md for all parameters and their effects.

---

### 9. Support & Customizations

The EA is fully configurable. For questions or desired adjustments, all parameters can be adjusted in the EA header.

🌐 **More Information:** [www.b0ss.dev](https://www.b0ss.dev)

**Good luck with trading!** 🚀