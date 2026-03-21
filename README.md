# lattice-ice40hx4k-project

Example blinky for the Lattice iCE40HX4K (TQ144) FPGA. Uses a fully open-source toolchain.

## Structure

```
├── rtl/
│   ├── top.v           # Verilog design
│   └── top.vhd         # VHDL design (alternative)
├── data/
│   └── top.pcf         # Pin constraints (iCE40HX4K TQ144)
├── scripts/
│   ├── build.sh        # Synthesize and generate bitstream
│   ├── flash.sh        # Program the FPGA
│   └── activate_venv.sh
├── lattice-ice40hx4k-project.core  # FuseSoC core descriptor (CAPI2)
└── fusesoc.conf        # FuseSoC library configuration
```

## Behavior

24-bit counter driven by a 12 MHz clock. Each LED blinks at a different frequency:

| LED    | Counter bit    | Frequency |
|--------|----------------|-----------|
| Green  | `counter[23]`  | ~0.7 Hz   |
| Red    | `counter[22]`  | ~1.4 Hz   |
| Yellow | `counter[21]`  | ~2.8 Hz   |
| Blue   | `counter[20]`  | ~5.7 Hz   |

## Requirements

- [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build) (yosys, nextpnr-ice40, icepack, iceprog)
- Python 3 + FuseSoC (`pip install fusesoc`)

## Usage

### Initial setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install fusesoc
```

### Build

```bash
./scripts/build.sh
```

### Program

```bash
./scripts/flash.sh
```

### Clean

```bash
rm -rf build
```

## Toolchain

```
top.v → [yosys] → top.json → [nextpnr-ice40] → top.asc → [icepack] → top.bin → [iceprog] → FPGA
```

## Pinout (iCE40HX4K TQ144)

| Signal     | Pin |
|------------|-----|
| clk        | 94  |
| led_green  | 1   |
| led_red    | 2   |
| led_yellow | 3   |
| led_blue   | 4   |
| btn1       | 31  |
| btn2       | 32  |
| btn3       | 33  |
| btn4       | 34  |

## License

MIT
