# Biomedical Device Protocol

A minimal protocol runtime written in R.

## Purpose

**Biomedical Device Protocol** explores a simple execution model:

```text
START
  ↓
protocol()
  ↓
EXECUTE
  ├── SUCCESS → END
  └── ERROR → jump(error) → END
```

The protocol is intentionally small.

The goal is to establish a clear relationship between **execution**, **failure**, and **response** without introducing unnecessary layers.

## Runtime

The entire runtime can exist in a single R script:

```r
protocol <- function() {
  # your program here
}

jump <- function(error) {
  # what happens if something goes wrong
}

tryCatch(
  protocol(),
  error = jump
)
```

The runtime has three fundamental components:

### `protocol()`

`protocol()` contains the program being executed.

It is the normal execution path.

```r
protocol <- function() {
  # your program here
}
```

### `jump(error)`

`jump()` defines what happens when execution encounters an error.

```r
jump <- function(error) {
  # what happens if something goes wrong
}
```

The error is passed to `jump()` so that the protocol can respond to the failure.

### `tryCatch()`

`tryCatch()` connects execution to the error path.

```r
tryCatch(
  protocol(),
  error = jump
)
```

This means:

> Execute `protocol()`. If an error occurs, jump to `jump()`.

## Execution

Execution proceeds in order:

```text
1. Start
2. Define protocol()
3. Define jump()
4. Execute protocol()
5. Continue if successful
6. Jump if an error occurs
7. End
```

The important distinction is between the **normal path** and the **exception path**.

```text
             protocol()
                 │
          ┌──────┴──────┐
          ↓             ↓
       SUCCESS         ERROR
          ↓             ↓
         END          jump()
                        ↓
                       END
```

## Consent

Consent can be treated as a condition of protocol execution.

Conceptually:

```text
CONSENT
   ↓
EXECUTION
```

If consent is not present, execution should not proceed.

Withdrawal of consent can likewise be treated as a condition that causes the protocol to leave its normal execution path.

In this project, the important principle is:

> **Consent is a condition of execution.**

This README describes the software model only. A real biomedical device requires appropriate consent mechanisms, safety controls, human factors, clinical requirements, testing, and applicable regulatory compliance.

## Withdrawal of Consent

Withdrawal of consent is distinct from an ordinary programming error.

Conceptually:

```text
EXECUTE
   ↓
CONSENT WITHDRAWN
   ↓
LEAVE PROTOCOL
```

If the implementation represents withdrawal by raising an R error, the same `jump()` mechanism can handle the resulting control flow.

However, a real device should not assume that an exception handler alone constitutes a safe response to withdrawal of consent.

## One Script

The protocol is designed to begin as one file:

```text
protocol.R
```

There is no requirement for a large framework or multiple runtime components.

The initial architecture is deliberately:

```text
protocol.R
```

containing:

```text
protocol()
jump()
tryCatch()
```

## Design Principles

### Minimal

Use as little machinery as necessary.

### Explicit

The execution path should be understandable by reading the source.

### Interruptible

The protocol must have a defined way to leave normal execution when a relevant condition occurs.

### Consent-aware

Execution should respect the presence or withdrawal of consent.

### Fail-safe by design

Errors should have an explicit path rather than being silently ignored.

### One-way execution

The basic model is:

```text
START → EXECUTE → END
```

with an alternate path:

```text
START → EXECUTE → ERROR → JUMP → END
```

## What This Is

This project is a **software/runtime model** for expressing a protocol in R.

It is useful for exploring:

* execution flow
* error handling
* interruption
* consent conditions
* protocol boundaries
* simple runtime architecture

## What This Is Not

This repository does not, by itself, constitute:

* a medical device
* medical advice
* a clinical protocol
* a validated safety system
* a regulatory compliance framework
* a substitute for professional biomedical engineering

Additional engineering and validation would be required before software could be used in an actual biomedical device.

## Getting Started

Install R, then run:

```bash
Rscript protocol.R
```

The program begins by executing:

```r
protocol()
```

If execution succeeds, the protocol follows its normal path.

If `protocol()` raises an error, `tryCatch()` transfers control to:

```r
jump(error)
```

## The Core

At its smallest, the project is simply:

```r
protocol <- function() {
  # your program here
}

jump <- function(error) {
  # what happens if something goes wrong
}

tryCatch(
  protocol(),
  error = jump
)
```

Everything else can be built from this foundation.

## Philosophy

**Run the protocol.**

**Respect the conditions of execution.**

**If something goes wrong, jump.**

**End cleanly.**
