#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BITSTREAM="$PROJECT_DIR/build/local_sandbox_lattice-ice40hx4k-project_0.1.0/synth-icestorm/local_sandbox_lattice-ice40hx4k-project_0.1.0.bin"

if ! command -v iceprog &> /dev/null; then
    echo "Error: iceprog not found. Install OSS CAD Suite first." >&2
    exit 1
fi

if [ ! -f "$BITSTREAM" ]; then
    echo "Error: bitstream not found at $BITSTREAM" >&2
    echo "Run ./scripts/build.sh first." >&2
    exit 1
fi

echo "Programming FPGA with $BITSTREAM ..."
iceprog "$BITSTREAM"
echo "Done."
