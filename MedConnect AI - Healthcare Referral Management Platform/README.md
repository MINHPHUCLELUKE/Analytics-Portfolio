# MedConnect AI — Healthcare Referral Management Platform

A clickable single-page prototype of an AI-assisted GP portal for managing patient referrals in the Australian healthcare system, built for an Information Systems / Business Analysis course. The prototype walks through the complete referral lifecycle, from creation to specialist response, with UI state, patient records, analytics and messaging screens.

> **Prototype only.** There is no backend, no real AI model and no real patient data. Every patient, KPI, accuracy figure and compliance feature in the prototype is illustrative mock content written to demonstrate the design.

---

## Illustrative KPIs shown in the prototype (mock values)

- 31 active referrals in queue
- 163 total patients managed
- 96% AI referral matching accuracy (a placeholder value, not a measured result)
- 2.1 days average wait time
- 14 minutes saved per referral vs manual process

---

## Features Implemented

**Referral management**
- 4-step referral creation wizard (patient selection → clinical notes → specialist matching → review)
- Simulated AI specialist matching with mock confidence scores (88–97% per match)
- Full referral lifecycle: Pending · Approved · Completed · Archived · Draft · Submitted · Declined · Forwarded · Cancelled
- Auto-escalation and re-routing of overdue referrals

**Patient management**
- New patient registration flow with Medicare and clinical history fields
- Detailed patient profiles with conditions, allergies, and referral history

**Analytics dashboard**
- AI performance metrics, specialty breakdown, monthly volume trends
- High-risk patient alerts, batch referral optimisation, seasonal pattern detection

**Other**
- Appointment calendar integration
- Secure encrypted GP-to-specialist messaging
- Notification preferences and system integration settings

---

## Australian healthcare context considered in the design

The design accounts for the Privacy Act 1988, AHPRA practitioner registration, PRODA, My Health Record and MedicalDirector integration. These appear as design requirements and settings screens only: the prototype is not certified, accredited or connected to any of these systems.

---

## Tools

`HTML` · `CSS` · `JavaScript` (no backend — fully client-side prototype)

---

## Output

**[Open the prototype (live)](https://minhphucleluke.github.io/Analytics-Portfolio/MedConnect%20AI%20-%20Healthcare%20Referral%20Management%20Platform/medconnectai.html)**

Interactive prototype file: [`medconnectai.html`](./medconnectai.html)
