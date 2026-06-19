# Software & System Deconstruction using UML Models

UML analysis of the real booking and scheduling system used by Kis Hair Melbourne — a multi-outlet CBD hair salon operating on the MaBa platform. The report reverse-engineers the system's architecture, maps the full booking workflow, identifies a functional gap, and proposes a concrete enhancement with quantified business value.

---

## System Context

- **Organisation:** Kis Hair Melbourne (3 flagship CBD outlets, incl. Shop 4/250 Spencer Street)
- **Platform:** MaBa booking system
- **Industry:** Australian hair and beauty sector — AUD $7.5 billion revenue, 33,500+ businesses

---

## UML Diagrams Produced

- **Activity diagram** — 4 swimlanes: Client · Booking UI · Kis Hair System · Notification Service Provider; maps the full booking flow including decision nodes and confirmation/notification paths
- **Use case model** — actors (Client, Staff, Admin) and their interactions with system functions
- **Class diagram** — data structures, relationships, and cardinalities
- **State machine** — booking object lifecycle from initiated to confirmed/cancelled

---

## Gap Analysis and Proposed Enhancement

**Gap identified:** No card-on-file or cancellation fee enforcement mechanism — unlike comparable platforms (Timely, Fresha, Square, Treatwell, Booksy).

**Proposed solution:** Payment authorisation capture integrated into the booking creation flow, with a configurable cancellation policy window.

**Business case:** Revenue leakage from no-shows; stylist idle time; competitive disadvantage against platforms with built-in late-cancellation fees.

---

## Tools

UML · Diagramming tools

---

## Output

Full report (46 pages): [`Software_System Deconstruction_KIS Booking_Minh Phuc LE.pdf`](./Software_System%20Deconstruction_KIS%20Booking_Minh%20Phuc%20LE.pdf)
