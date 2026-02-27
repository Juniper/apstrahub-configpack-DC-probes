# DC Probes

## What does this Config Pack Do

This config pack creates the IBA elements required to collect BER (Bit Error Rate), FEC (Forward Error Correction), and interface counter telemetry from Junos EVO devices.

## JunOS Compatibility

This Config Pack targets `junos_evo` on `qfx-ms-fixed` family devices.

## Components

| Component | Name | Description |
|-----------|------|-------------|
| Service Registry | ber | Service schema for BER and interface counter telemetry |
| Service Registry | histogram | Service schema for FEC histogram telemetry |
| Custom Collector | ber_collector | Collects BER, CRC errors, and packet/byte counters via `show interfaces extensive` |
| Custom Collector | histogram_collector | Collects FEC histogram bin data via `show interfaces extensive` |
| Probe | dc-ber-intf-counters | Probe that consumes both collectors and exposes BER and histogram stages |
