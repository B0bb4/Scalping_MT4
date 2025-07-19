# ScalpingEA - Functions & Parameter Reference
*by Alexander Boß* | 🌐 [www.b0ss.dev](https://www.b0ss.dev)

## 🎯 All Adjustable Parameters - BOTH VERSIONS

### 📋 Overview
**Two versions available:**
- 💱 **ScalpingEA.mq4** (Forex Edition)
- 💎 **ScalpingEA_Crypto.mq4** (Crypto Edition)

Both Expert Advisors are fully customizable. All parameters can be changed in the EA settings (F7) without programming knowledge.

### 🔄 **Main Differences Between Versions:**

| Parameter | Forex Version | Crypto Version |
|-----------|---------------|----------------|
| **Default Lot Size** | 0.01 | 0.005 |
| **Spread Unit** | Pips (0.5-5) | Percent (0.01-0.5%) |
| **Take Profit** | 50-75 Pips | 1000-1500 Points |
| **Volatility Filter** | 1% | 2% |
| **Magic Number** | 54321 | 12345 |
| **Optimized for** | EURUSD, GBPUSD | BTCUSD, ETHUSDT |

**All other parameters are identical!**

---

## 🔧 BASIC SETTINGS

### **LotSize** *(Default: 0.005)*
**What it is:** Position size per trade  
**Effect:** Higher = more profit AND loss  
**Recommendation:** Start with 0.01, later up to 0.05  
**Warning:** Too high can destroy account!

### **RiskPercent** *(Default: 1.0)*
**What it is:** Risk per trade as percentage of account  
**Effect:** Automatic lot size calculation  
**Recommendation:** 1-3% depending on experience  
**Note:** Overrides LotSize when dynamic calculation is active

### **AccountBalance** *(Default: 500.0)*
**What it is:** Reference account balance for calculations  
**Effect:** Basis for risk calculation  
**Recommendation:** Set to actual account size  
**Automatic:** Detected by EA if not set

### **MaxTradesPerDay** *(Default: 3)*
**What it is:** Maximum number of trades per day  
**Effect:** EA stops after reaching limit  
**Recommendation:** 2-5 depending on strategy  
**Customer Profile:** Optimized for 2-3 high-quality trades

### **RiskRewardRatio** *(Default: 2.5)*
**What it is:** Profit to loss ratio  
**Effect:** 2.5 = 2.5x more profit than risk  
**Recommendation:** 1.5-3.0 depending on experience  
**Higher:** Fewer trades, but larger profits

---

## ⏰ TRADING HOURS

### **RestrictedTradingHours** *(Default: true)*
**What it is:** Enable limited trading hours  
**Effect:** EA trades only during specified times  
**Customer Profile:** Optimized for 15:45-17:45 German time

### **TradingStartHour/Minute** *(Default: 15:45)*
**What it is:** Daily trading start  
**Effect:** EA starts trading from this time  
**Customer Profile:** 15:45 for NY pre-market phase

### **TradingEndHour/Minute** *(Default: 17:45)*
**What it is:** Daily trading end  
**Effect:** EA stops trading after this time  
**Customer Profile:** 17:45 after NY open phase

### **NYOpenFocus** *(Default: true)*
**What it is:** Enhanced activity around NY Open  
**Effect:** More aggressive strategy around 15:30  
**Bonus:** Larger lot sizes and extended TPs

### **SundayTradingOnly** *(Default: true)*
**What it is:** Trade only Sunday on weekends  
**Effect:** Saturday completely blocked  
**Customer Profile:** Reduces weekend risks

---

## 📊 SIGNAL SETTINGS

### **VolumeMultiplier** *(Default: 2.5)*
**What it is:** How much volume must increase for signal  
**Effect:** Lower = more signals, higher = fewer but stronger  
**Adjustment:**
- `1.2` = Many trades (8-15/day)
- `2.5` = Few, strong trades (2-5/day)
- `3.0` = Very selective

### **SwingPeriod** *(Default: 15)*
**What it is:** Period for turning point search  
**Effect:** Lower = more reactive, higher = more stable  
**Adjustment:**
- `15` = Fast reaction (more signals)
- `25` = Stable signals (fewer false signals)
- `30` = Very conservative

### **BreakoutThreshold** *(Default: 0.002)*
**What it is:** Minimum movement for breakout signal  
**Effect:** 0.2% price movement required  
**Crypto-optimized:** Higher threshold due to volatility

---

## 🛡️ RISK MANAGEMENT

### **MaxDrawdownPercent** *(Default: 2.0)*
**What it is:** Maximum allowed drawdown  
**Effect:** EA stops when exceeded  
**Customer Profile:** Strict 2% limit  
**Protection:** Automatic trading stop

### **UseATR_SL** *(Default: true)*
**What it is:** Automatic Stop Loss adjustment  
**Effect:** EA adapts SL to market volatility  
**IMPORTANT:** Never set to false!  
**Advantage:** Fewer stop-outs

### **ATR_Multiplier** *(Default: 3.0)*
**What it is:** Factor for Stop Loss distance  
**Effect:** Higher = wider stops, fewer stop-outs  
**Adjustment:**
- `2.0` = Tight stops (more stop-outs)
- `3.0` = Standard (balanced)
- `4.0` = Wide stops (larger possible losses)

### **TrailingDistance** *(Default: 250)*
**What it is:** Distance for Trailing Stop  
**Effect:** How close the stop follows price  
**Function:** Secures profits on trend reversal

---

## 📰 NEWS & FILTERS

### **NewsFilter** *(Default: false)*
**What it is:** Pause trading during important news  
**Effect:** Protection from news volatility  
**Times:**
- FOMC: Wednesday 20:00 German time
- CPI: Tuesday/Thursday 14:30 German time
**Dashboard:** Shows status live

### **AvoidFOMC** *(Default: true)*
**What it is:** Avoid Fed meetings  
**Effect:** No trading during Fed sessions  
**Active only if:** NewsFilter = true

### **AvoidCPI** *(Default: true)*
**What it is:** Avoid inflation data  
**Effect:** No trading during CPI releases  
**Active only if:** NewsFilter = true

---

## 📈 TAKE PROFIT & STOP LOSS

### **SL_Points** *(Default: 400)*
**What it is:** Fallback Stop Loss in points  
**Effect:** Only used when ATR fails  
**Recommendation:** Use UseATR_SL = true

### **TP_Points** *(Default: 1000)*
**What it is:** First Take Profit level  
**Effect:** Primary profit target  
**Customer Profile:** Optimized for higher profits

### **TP2_Points** *(Default: 1500)*
**What it is:** Second Take Profit level  
**Effect:** Extended profit opportunities  
**Function:** For strong trends

---

## 🔊 ALERTS & INTERFACE

### **EnableAlerts** *(Default: true)*
**What it is:** Enable popup messages  
**Effect:** Important events are displayed  
**Recommendation:** Always keep on true

### **EnableSounds** *(Default: true)*
**What it is:** Sound notifications  
**Effect:** Acoustic signals for events  
**Sounds:**
- Entry: `alert.wav`
- Exit: `alert2.wav`
- Win: `ok.wav`
- Loss: `timeout.wav`

### **EnableDashboard** *(Default: true)*
**What it is:** Show live dashboard  
**Effect:** Information top left in chart  
**Content:** Status, statistics, trades, times

---

## 🎨 VISUAL SETTINGS

### **ShowEntryArrows** *(Default: true)*
**What it is:** Entry arrows in chart  
**Display:**
- 🟢 Green arrow up = BUY
- 🔴 Red arrow down = SELL

### **ShowExitArrows** *(Default: true)*
**What it is:** Exit arrows in chart  
**Display:** ❌ X symbol on position close

### **ShowSuccessSymbols** *(Default: true)*
**What it is:** Success symbols after trades  
**Display:**
- ✅ Green checkmark + profit = Win
- ❌ Red X + loss = Loss

### **ShowVolatilityZones** *(Default: true)*
**What it is:** Mark volatility areas  
**Function:** Shows extreme volume spikes

---

## 🔢 TECHNICAL INDICATORS

### **RSI_Period** *(Default: 12)*
**What it is:** Period for RSI indicator  
**Effect:** Shorter period = more reactive  
**Only change if:** You understand RSI

### **RSI_Overbought/Oversold** *(Default: 75/25)*
**What it is:** Overbought/Oversold levels  
**Crypto-optimized:** Extended ranges  
**Effect:** Exit signals

### **EMA_Fast/Medium/Slow** *(Default: 8/18/42)*
**What it is:** Moving averages  
**Function:** Trend detection  
**Only for:** Experienced traders

---

## ⚙️ CRYPTO-SPECIFIC PARAMETERS

### **CryptoMode** *(Default: true)*
**What it is:** Enable crypto optimizations  
**Effect:** Higher volatility tolerance  
**Features:** 24/7 trading, adapted indicators

### **MinSpread/MaxSpread** *(Default: 0.0001/0.005)*
**What it is:** Spread limits for trading  
**Effect:** No trading with too high spreads  
**Protection:** From poor executions

### **VolatilityFilter** *(Default: 0.02)*
**What it is:** Volatility filter (2%)  
**Effect:** No trading during extreme volatility  
**Crypto:** Important due to frequent spikes

---

# 📋 QUICK REFERENCE

## 🚀 FOR MORE TRADES:
```
VolumeMultiplier = 1.2
SwingPeriod = 15
MaxTradesPerDay = 5
```

## 🛡️ FOR SAFER TRADES:
```
VolumeMultiplier = 2.5
SwingPeriod = 25
ATR_Multiplier = 3.5
MaxDrawdownPercent = 1.5
```

## 💰 FOR HIGHER PROFITS:
```
RiskRewardRatio = 3.0
TP_Points = 1500
NYOpenFocus = true
```

## ⏰ FOR SPECIFIC TIMES:
```
RestrictedTradingHours = true
TradingStartHour = 15
TradingEndHour = 17
NewsFilter = true
```

---

## ❌ NEVER CHANGE:
- `MagicNumber` = EA identifies its trades by this
- `UseATR_SL` = Always keep on true
- `EnableAlerts` = Otherwise you'll miss signals

## ⚠️ ONLY CHANGE WITH EXPERIENCE:
- RSI, MACD, EMA parameters
- Spread settings
- Volatility filters

---

🌐 **Support:** [www.b0ss.dev](https://www.b0ss.dev)  
📚 **Setup Guide:** See EA_Setup_Anleitung.md  
🔧 **Installation:** See EA_Setup_Guide_EN.md