# lattice-ice40hx4k-project

Starter template for standalone Verilog experiments on the Lattice
iCE40HX4K (TQ144). Uses a fully open-source toolchain (Yosys, nextpnr,
IceStorm) driven through FuseSoC. Everything here is self-contained -- copy
this repository to start a new experiment.

## Structure

```text
├── rtl/
│   └── top.v                       # Verilog design (replace with your RTL)
├── data/
│   └── top.pcf                     # Pin constraints (iCE40HX4K TQ144)
├── scripts/
│   ├── setup.sh                    # Create venv + install requirements
│   ├── build.sh                    # Synthesize and generate bitstream
│   └── flash.sh                    # Program the FPGA
├── lattice-ice40hx4k-project.core  # FuseSoC core descriptor (CAPI2)
├── fusesoc.conf                    # FuseSoC library configuration
└── requirements.txt                # Python dependencies (FuseSoC)
```

## Using it for a new experiment

1. Replace `rtl/top.v` with your design, and uncomment/add the pins you need
   in `data/top.pcf`. Only use pins already listed there (confirmed working)
   unless you've checked the board's schematic for anything else.
2. Optionally rename the core: in `lattice-ice40hx4k-project.core`, change
   `name:` (e.g. `local:sandbox:my-experiment:0.1.0`), and update `CORE_NAME`
   / `BITSTREAM` in `scripts/build.sh` and `scripts/flash.sh` to match.

## Placeholder design

`rtl/top.v` ships with a minimal design that confirms the toolchain works
end-to-end on a fresh copy of the template: a free-running 24-bit counter
that blinks a single LED at ~0.7 Hz.

| Signal  | Direction | Description                  |
| ------- | --------- | ---------------------------- |
| `clock` | input     | 12 MHz board clock           |
| `o_led` | output    | LED, driven by `counter[23]` |

## Requirements

- [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build) (yosys, nextpnr-ice40, icepack, iceprog)
- Python 3 + FuseSoC (see `requirements.txt`)
- [Verible](https://github.com/chipsalliance/verible/releases) + [pre-commit](https://pre-commit.com/) (Verilog format/lint checks, optional but recommended)

### Installing OSS CAD Suite

```bash
tar -xzf oss-cad-suite-linux-x64-*.tgz -C ~/.local
export PATH="$HOME/.local/oss-cad-suite/bin:$PATH"
```

**Don't** `source oss-cad-suite/environment` -- it shadows the system `python3`
with the suite's bundled one (no `ensurepip`), which breaks `scripts/setup.sh`'s
`python3 -m venv` step.

### Enabling the pre-commit hooks

```bash
python3 -m venv .venv
.venv/bin/pip install pre-commit
.venv/bin/pre-commit install
```

This installs a git hook that formats and checks the syntax of `.v`/`.sv`
files with `verible-verilog-format` / `verible-verilog-syntax` before each
commit. If the formatter modifies a file, the commit is aborted -- re-stage
and commit again. The same checks run on every push/PR via the
[`verible.yml`](.github/workflows/verible.yml) GitHub Actions workflow.

## Usage

```bash
./scripts/build.sh   # Creates .venv on first run, synthesizes + place & route + bitstream -> build/
./scripts/flash.sh   # Program the FPGA
rm -rf build         # Clean
```

## Toolchain

```text
rtl/top.v -> [yosys] -> netlist.json -> [nextpnr-ice40] -> top.asc -> [icepack] -> top.bin -> [iceprog] -> FPGA
```

## Known-good pinout (iCE40HX4K TQ144)

| Signal     | Pin | Status    |
| ---------- | --- | --------- |
| clock      | 94  | wired     |
| o_led      | 1   | wired     |
| led_red    | 2   | available |
| led_yellow | 3   | available |
| led_blue   | 4   | available |
| btn1       | 31  | available |
| btn2       | 32  | available |
| btn3       | 33  | available |
| btn4       | 34  | available |
