# Plan template

Write `plan.md` in the working folder (outside the docs repo) with these sections, in this order. Keep it thin: the house rules carry everything general, and the plan holds only what's specific to this guide.

The plan should work as a handover. Another agent session, given only `plan.md` and this skill, must be able to build the guide.

```markdown
# Plan: "<working title>" how-to

Read `.claude/skills/create-how-to-doc/references/house-rules.md` first. It's binding.

## The reader's job
> "<one sentence, in the reader's words>"
- Uses to cover: <every way the feature serves the job>
- Setups it works in: <don't assume one>
- Who reads it: <from the interview>
- Concepts to explain in a sentence where first needed: <e.g. Git worktree>

## The opening
- Comparable products researched, with links: <3>
- Five candidate openings, ranked, each checked against house rules §2a: <1–5>
- Title options: <3>, with the slug and uid for each
- Description and index.md link line for the top choice
- Topic pitfalls: <ways this topic tempts a bad opening>

## Outline
<H2s with one line each on what the section tells the reader. No "Before you start". Limitations only if real.>

## Scope
- In: <…>
- Probably left out (goes in the report's "Left out" list): <…>
- Out of scope (other guides): <…>

## Deliverables
| # | File | What |
<the guide + images; toc.yml; index.md line; approved supporting or concept pages; line-level fixes to existing pages, each with file:line and the fix>

## Leads to confirm
<Verbatim labels, behaviour and blockers, each with file:line. Marked UNCONFIRMED where unsure. Never written as facts.>

## Existing docs
- Pages that cover this, and what they say
- Outdated statements (file:line): the ones to fix (contradict this guide) and the ones to report only
- Concept gaps

## Sample and flow
<Sample location, any additions to it (commits allowed in sample repos), the chats to run (named `Acme · …`), and the exact prompts.>

## Shot list
| # | Shot | Notes (crop, highlight, privacy, human capture?) |

## Privacy
<The off-limits folders from the interview, plus topic-specific risks, e.g. the Agents board lists every conversation, and worktree paths contain the user name.>

## Report extras
<Topic-specific results the report must include, e.g. the outcome of a behaviour test.>
```
