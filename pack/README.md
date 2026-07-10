# DC Probes

## What does this Config Pack Do

This config pack creates the IBA elements required to collect the following telemetry from Junos devices:

- CPU
- Memory
- BER (Bit Error Rate)
- FEC (Forward Error Correction)
- Interface counters

It also creates elements to monitor the following on the same devices:

- BFD (Bidirectional Forwarding Detection) sessions

## Components

| Component | Name | Description |
| ----------- | ------ | ------------- |
| Service Registry | ber | Service schema for BER and interface counter telemetry |
| Service Registry | histogram | Service schema for FEC histogram telemetry |
| Service Registry | bfd_sessions | Service schema for BFD session monitoring |
| Custom Collector | ber_collector | Collects BER, CRC errors, and packet/byte counters via `show interfaces extensive` |
| Custom Collector | histogram_collector | Collects FEC histogram bin data via `show interfaces extensive` |
| Custom Collector | bfd_sessions_collector | Collects BFD session state via `show bfd session extensive` |
| Probe | dc-ber-intf-counters | Probe that consumes both collectors and exposes BER and histogram stages |
| Probe | dc-cpu-memory-stream | Probe that Streams CPU and memory utilisation to DC Assurance |
| Probe | dc-bfd-sessions | Probe that consumes the BFD collector and exposes BFD session state |
