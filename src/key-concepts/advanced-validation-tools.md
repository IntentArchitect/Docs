---
uid: key-concepts.codebase-integration
description: "How Intent Architect's Change Review denoises the pull request process with AI review and healing, severity classification, and model-centric diffs."
---

# Advanced Validation Tools

When agents do most of the coding, validation processes become the new delivery bottleneck – and teams either slow down to review properly or just rubberstamp code and push lots of risk downstream. Intent Architect's Change Review system optimizes code reviews and denoises the pull request (PR) process. It runs a comprehensive AI-driven review and healing pass, and combines it with deterministically-driven severity classification and model-centric diffs, so the most important and high-impact changes are prioritized in a way that's intuitive to developers – and you can review quickly and effectively at the same time.

---

## Key benefits

- **🔍 Streamline validation processes and stay in control as review volume grows**

  Code reviews stay efficient, effective and manageable as the volume of agent-written code grows. Intent Architect's Change Review tool hooks into your team's preferred PR platform – GitHub, Azure DevOps, GitLab, Bitbucket etc. – to focus, optimize and denoise the pull request process. So teams sustain review discipline and remain accountable at any scale of agentic coding.

- **🎯 Review effort goes to the changes that matter**

  The most important and high-impact changes are prioritized as PR size grows. Change Review combines a comprehensive AI-driven review and healing pass with deterministically-driven severity classification and model-centric diffs, so developers see what changed, how much it matters, and what it means for the design. So teams review quickly and effectively at the same time.

- **🔗 Establish the why behind every change**

  Changes remain connected to the requirements and specifications that drove them. Change Review surfaces the traceability links on a change and answers the why, so reviewers can establish what it is for and where it came from as part of the review or PR. So teams stay accountable at a requirements level as they scale agentic coding.

---

## Change Review

Change Review is a code review system built for agentic development, where the volume of change is amplified beyond what conventional review processes can practically handle. It is a central place to optimize and review all codebase changes, whether deterministically generated or written by agents (or developers).

It hooks into your team's preferred PR platform – GitHub, Azure DevOps, GitLab, Bitbucket etc. – and denoises the pull request process through four components. An AI review and healing system finds and corrects issues across the change. Deterministically-driven severity classification flags what carries risk, so review effort goes to what matters most. Model-centric diffs show what a change means for the design, not just the code. And traceability links surface the requirements and specifications behind a change, so reviewers can establish why it exists.

<br>

![Change Review](images/changes-review.png)
_An example of the Change Review for the working tree against the Git HEAD._

---

## AI Review and Healing

An AI review runs directly on a pull request, over its actual merge-base to head range, using the same review engine as Change Review. Findings land as a pending review draft rather than being posted one at a time, so you read, edit or drop each one and submit the whole review yourself. Where a finding can be corrected, the agent can heal it – detecting the drift and fixing it rather than only flagging it.

A re-run skips anything already flagged, including on threads that have since been resolved, so repeated reviews do not accumulate duplicate comments.

---

## Severity Classification and Model-Centric Diffs

Deviations and custom files are tagged with colour-coded File Classification elements and a severity flag – none, low, medium or high. Classification is checked against git-classified file operations and canonicalized file paths, using the same logic Change Review itself uses, so severity reflects what actually changed rather than what an agent reported. A Needs Attention filter surfaces files by severity and classification, based on your bespoke configuration.

Model-centric diffs show what a change means for the design, not just the code. Hovering a change pill reveals field-level before and after values for an element or association, and reviewers can click through to the affected models to see how the domain and service models shifted.

---

## Learn More

- **[Reliable Architectural Guardrails](xref:key-concepts.deterministic-codegen)**
- **[Authoritative Design Blueprints](xref:key-concepts.visual-modeling)**
- **[Spec-Driven Development with Traceability](xref:key-concepts.non-deterministic-codegen)**
