# 3-Stage Current Starved Ring Oscillator (CSRO) in 180nm CMOS

A production-ready physical implementation and post-layout verification of a **3-Stage Current Starved Ring Oscillator (CSRO)** designed in **180nm CMOS technology (1.8V supply)** using the **Cadence Virtuoso Suite**.

This design achieves an ultra-wide frequency tuning range of $36.3\times$ ($70.2\text{ MHz}$ to $2.548\text{ GHz}$), excellent temperature stability ($\pm 3.3\%$), zero physical verification errors (DRC & LVS clean across 21 devices), and $100\%$ yield across 200 Monte Carlo process variation samples.

##  Overview & Highlights

* **Peak Frequency:** $2.548\text{ GHz}$ at $V_{ctrl} = 1.8\text{ V}$

* **Tuning Range:** $36.3\times$ ($70.2\text{ MHz}$ to $2.548\text{ GHz}$)

* **Power Efficiency:** $1.763\,\mu\text{W}$ at $70.2\text{ MHz}$ up to $162.7\text{ mW}$ at $2.548\text{ GHz}$

* **Core Layout Area:** $\approx 80\,\mu\text{m} \times 60\,\mu\text{m}$ ($\approx 4,800\,\mu\text{m}^2$)

* **Process Robustness:** Verified over 36 PVT Corners ($SS$, $SF$, $NN$, $FS$, $FF$) & extended temperatures ($0^{\circ}\text{C}$ to $80^{\circ}\text{C}$)

## Key Performance Summary

| Metric | Target Specification | Achieved Post-Layout Value | Status | 
| ----- | ----- | ----- | ----- | 
| **Peak Oscillation Frequency (**$f_{max}$**)** | $> 2.0\text{ GHz}$ | $2.548\text{ GHz}$ | Exceeds Target | 
| **Frequency Tuning Range (**$\Delta f$**)** | $> 20\times$ | $36.3\times$ **(**$70.2\text{ MHz} - 2.548\text{ GHz}$**)** | $81.5\%$ Above Target | 
| **Peak Power Consumption (**$P_{max}$**)** | $< 200\text{ mW}$ | $162.7\text{ mW}$ | Pass | 
| **Temperature Stability (**$0 - 80^{\circ}\text{C}$**)** | $\pm 5\%$ | $\pm 3.3\%$ | Pass | 
| **DRC Violations** | $0$ | $0$ | Clean | 
| **LVS Mismatches** | $0$ | $0$ **(21 devices & netlist matched)** | Clean | 
| **Monte Carlo Yield (200 Runs)** | $> 95\%$ | $100\%$ | Pass | 
| **PVT Corner Coverage** | Critical Corners | **36 Functional Corners** | Pass | 

##  Circuit Architecture & Sizing

The oscillator core consists of a three-stage inverter chain in a closed loop (providing the necessary $180^{\circ}$ phase shift from inverter delays plus $180^{\circ}$ DC feedback shift for sustained oscillation) modulated by an NMOS/PMOS current-starving bias mirror network.

```
                  VDD (1.8V)
                   │
         ┌─────────┴─────────┐
         │     PMOS Mirrors  │
         │  (Current Starve) │
         └─────────┬─────────┘
                   │
    ┌──────────────┼──────────────┐
    │              │              │
┌───┴───┐      ┌───┴───┐      ┌───┴───┐
│Inv 1  ├─────>│Inv 2  ├─────>│Inv 3  ├───┬──> Vosc Output
└───┬───┘      └───┬───┘      └───┬───┘   │
    │              │              │       │
    └──────────────┼──────────────┘       │
                   │                      │
         ┌─────────┴─────────┐            │
         │     NMOS Mirrors  │            │
         │  (Current Starve) │            │
         └─────────┬─────────┘            │
                   │                      │
                  GND                     │
                   ▲                      │
                   └──────────────────────┘ (Feedback Loop)

```

### Transistor Sizing Details

| Transistor Role | Device Type | Width ($W$) | Length ($L$) | $W/L$ Ratio | Function / Rationale | 
| ----- | ----- | ----- | ----- | ----- | ----- | 
| **Inverter Pull-Down** | NMOS | $2.0\,\mu\text{m}$ | $0.18\,\mu\text{m}$ | $11.1$ | Fast switching & pulldown transition | 
| **Inverter Pull-Up** | PMOS | $4.0\,\mu\text{m}$ | $0.18\,\mu\text{m}$ | $22.2$ | Mobility compensation for symmetric $t_r / t_f$ | 
| **Current Mirror Ref** | NMOS | $1.0\,\mu\text{m}$ | $0.18\,\mu\text{m}$ | $5.6$ | Precision current reference; minimal area | 

### Mathematical Relations

* **Mirror Current:**
  

  $$
  I_{bias} \propto (V_{ctrl} - V_{th})^2
  $$

* **Oscillation Frequency:**
  

  $$
  f_{osc} = \frac{1}{2 \cdot N \cdot t_d} \propto I_{bias}
  $$

  
  *(where* $N=3$ *stages and* $t_d$ *is stage delay).*

## 📐 Physical Design & Verification

The physical layout was designed in Cadence Virtuoso with high-speed symmetry, minimal parasitic overlap, and robust supply routing.

* **Die Core Area:** $\approx 4,800\,\mu\text{m}^2$ ($80\,\mu\text{m} \times 60\,\mu\text{m}$)

* **Metal Layer Usage:**

  * **Metal 1 (M1):** Local interconnects, high-speed stage signals, $V_{ctrl}$ line ($\sim 4\,\mu\text{m}$ width).

  * **Metal 2 (M2):** Power rails ($V_{DD}$ and $\text{GND}$) ($\sim 6\,\mu\text{m}$ width).

  * **Vias (**$M1 \leftrightarrow M2$**):** Distributed regularly every $10-15\,\mu\text{m}$ to control IR drop.

* **IR Drop Analysis:** Supply ripple $< 20\text{ mV}$ under peak current draw ($< 1\text{ mA}/\mu\text{m}^2$ current density).

### DRC & LVS Sign-Off

* **DRC:** Clean ($0$ errors found in Cadence Assura / PVS).

* **LVS:** $0$ Net mismatches, $0$ Device mismatches, $0$ Pin mismatches across all 21 extracted devices.

##  Post-Layout Simulation Results

### 1. Parametric Voltage Tuning ($V_{ctrl}$ Sweep)

| $V_{ctrl}$ (V) | Frequency ($f_{osc}$) | Power Consumption | Output $V_{max}$ (V) | Region | 
| ----- | ----- | ----- | ----- | ----- | 
| **0.50** | $70.2\text{ MHz}$ | $1.763\,\mu\text{W}$ | $0.497\text{ V}$ | Subthreshold | 
| **0.70** | $323.4\text{ MHz}$ | $10.36\,\mu\text{W}$ | $0.603\text{ V}$ | Transition | 
| **0.90** | $1037\text{ MHz}$ | $42.92\,\mu\text{W}$ | $0.780\text{ V}$ | Linear Active | 
| **1.00** | $1547\text{ MHz}$ | $73.41\,\mu\text{W}$ | $0.894\text{ V}$ | Active | 
| **1.20** | $2499\text{ MHz}$ | $157.1\,\mu\text{W}$ | $1.154\text{ V}$ | High Speed | 
| **1.50** | $2.356\text{ GHz}$ | $138.4\text{ mW}$ | $1.105\text{ V}$ | Saturation Knee | 
| **1.80** | $2.548\text{ GHz}$ | $162.7\text{ mW}$ | $1.169\text{ V}$ | Peak Performance | 

### 2. Process, Voltage, & Temperature (PVT) Corner Coverage (36 Corners)

Simulations across 36 combinations of process corners ($NN, FS, SF, SS, FF$), temperatures ($0^{\circ}\text{C}, 20^{\circ}\text{C}, 80^{\circ}\text{C}$), and supply variations ($1.78\text{ V}, 1.80\text{ V}, 1.82\text{ V}$) confirmed robust operation:

* **Fastest Corner (**$C1\_0 - FS, 0^{\circ}\text{C}, 1.78\text{V}$**):** $2.945\text{ GHz}$ (+15.5% relative to nominal)

* **Nominal Corner (**$C2\_0 - NN, 0^{\circ}\text{C}, 1.78\text{V}$**):** $2.590\text{ GHz}$ (Baseline)

* **Slowest Corner (**$C4\_2 - SS, 80^{\circ}\text{C}, 1.78\text{V}$**):** $1.583\text{ GHz}$ (-37.9% relative to nominal)

* **Corner Stability:** All 36 corners successfully generated stable oscillations without failure.

### 3. Monte Carlo Yield & Statistical Analysis (200 Samples)

A 200-point Monte Carlo analysis incorporating channel length modulation ($\Delta L_{eff} = \pm 3\%$), gate oxide variation ($\Delta T_{ox} = \pm 2\%$), threshold voltage mismatch ($\Delta V_{th} = \pm 10\text{ mV}$), and parasitic RC variations ($\pm 5\%$) yielded:

| Parameter | Pass Yield | Mean ($\mu$) | Std. Dev. ($\sigma$) | Distribution Fitting | 
| ----- | ----- | ----- | ----- | ----- | 
| **Frequency (**$f_{osc}$**)** | $100.0\%$ | $2.533\text{ GHz}$ | $293.4\text{ MHz}$ | Gaussian (Jarque-Bera: 3.13) | 
| **Period (**$1/f_{osc}$**)** | $100.0\%$ | $400.1\text{ ps}$ | $46.82\text{ ps}$ | Gaussian (Jarque-Bera: 6.81) | 
| **Average Power** | $100.0\%$ | $162.9\,\mu\text{W}$ | $19.29\,\mu\text{W}$ | Gaussian (Jarque-Bera: 12.10) | 
| **Output Swing (**$V_{pp}$**)** | $100.0\%$ | $1.163\text{ V}$ | $42.93\text{ mV}$ | Gaussian (Jarque-Bera: 0.25) | 

##  Signal Integrity & Jitter

* **Rise Time (**$t_r$**):** $\sim 80\text{ ps}$

* **Fall Time (**$t_f$**):** $\sim 90\text{ ps}$ (Symmetric transition)

* **Phase Separation:** Exact $120^{\circ}$ phase displacement across the three ring stages.

* **Period-to-Period Jitter:** $< \pm 1\text{ ps}$ over 10 consecutive cycles.

* **RMS Jitter:** $\sim 0.3\text{ ps}$ ($0.076\%$ jitter ratio relative to period).

##  Repository Structure

```
├── docs/
│   ├── CSRO_Technical_Report.pdf       # Comprehensive 23-page design report
│   └── architecture_diagram.png       # Block diagram & schematics
├── cadence/
│   ├── csro_schematic.cds              # Virtuoso schematic view netlist
│   ├── csro_layout.gds                 # GDS-II physical layout file
│   └── csro_extracted.spice            # Post-layout parasitic extracted netlist (AV EXT)
├── data/
│   ├── csro_parametric_sweep.csv       # 112-point control voltage sweep data
│   ├── csro_pvt_36corners.xlsx         # Complete 36 PVT corner simulation spreadsheet
│   └── csro_monte_carlo_200.csv        # 200-sample Monte Carlo statistical data
└── README.md                           # Project documentation

```

##  Simulation & Verification Environment

* **CAD Suite:** Cadence Virtuoso IC6.1

* **Simulation Engine:** Spectre SPICE Simulator

* **Physical Verification:** Cadence Assura / PVS (DRC & LVS)

* **Parametric & Yield Analysis:** Cadence ADE XL

* **PDK:** Generic 180nm CMOS PDK (gpdk180)

### How to Run in Cadence Virtuoso

1. Clone the repository to your Cadence project directory:

   ```
   git clone https://github.com/your-username/3-Stage-CSRO-180nm.txt
   
   ```

2. Import `csro_layout.gds` into Virtuoso layout editor.

3. Run Assura DRC using `gpdk180` technology rules.

4. Run Assura LVS comparing `csro_schematic` vs `csro_layout`.

5. Launch ADE XL and load `csro_pvt_36corners` or `csro_monte_carlo_200` state files for automated post-layout transient verification.

##  Author

* **Name:** Kanishkar D

* **Technology:** 180nm CMOS

* **Date:** August 31, 2026
