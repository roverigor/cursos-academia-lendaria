# 14. Interaction Design Patterns

**Document:** MMOS Admin Dashboard - Interaction Design Patterns
**Version:** 1.0
**Last Updated:** 2025-10-29
**Owner:** UX Senior (Sally)

---

## 📋 Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [Micro-Interactions](#micro-interactions)
3. [Animation Guidelines](#animation-guidelines)
4. [Feedback Mechanisms](#feedback-mechanisms)
5. [Progressive Disclosure](#progressive-disclosure)
6. [Data Visualization](#data-visualization)
7. [Form Interactions](#form-interactions)
8. [Real-Time Updates](#real-time-updates)
9. [Error Prevention & Recovery](#error-prevention--recovery)
10. [Accessibility Interactions](#accessibility-interactions)

---

## Design Philosophy

### Core Principles

**1. Clarity Over Cleverness**
> Every interaction should communicate state clearly. If users are confused, the interaction failed.

**2. Responsiveness**
> Feedback should be immediate (<100ms). Users should never wonder "did that work?"

**3. Forgiveness**
> Users should be able to undo destructive actions. Mistakes happen, design for recovery.

**4. Discoverability**
> Interactions should be obvious. Users shouldn't need documentation to understand what's clickable.

**5. Consistency**
> Similar actions should behave similarly across the app. Muscle memory is powerful.

---

### Interaction Hierarchy

**Primary Actions** (most important)
- Visual weight: Solid color, high contrast
- Example: "Create Mind", "Start Pipeline"
- Always visible, never hidden in menus

**Secondary Actions** (supportive)
- Visual weight: Outline style, medium contrast
- Example: "Cancel", "View Details"
- Visible but less prominent

**Tertiary Actions** (rare, destructive)
- Visual weight: Text link or icon
- Example: "Delete", "Archive"
- Hidden in overflow menus (⋮)

---

## Micro-Interactions

### Button States

#### Idle State
```tsx
<Button className="
  bg-primary text-primary-foreground
  px-spacing-md py-spacing-sm
  rounded-md
  transition-all duration-200
  hover:bg-primary/90
  focus:ring-2 focus:ring-primary focus:ring-offset-2
  active:scale-95
">
  Create Mind
</Button>
```

**Visual Specs:**
- Background: `--primary` (HSL)
- Border radius: 6px
- Padding: 12px 24px
- Font size: 16px (text-body)
- Font weight: 500

---

#### Hover State (Desktop)

**Behavior:**
- Cursor changes: `cursor-pointer`
- Background darkens: `bg-primary/90` (10% opacity reduction)
- Transition: 200ms ease-in-out
- Subtle lift: `shadow-md` (4px elevation)

**Why:**
- Confirms button is interactive
- Provides tactile feedback before click
- Creates depth hierarchy

**Code:**
```css
.button:hover {
  background: hsl(var(--primary) / 0.9);
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  transform: translateY(-1px);
}
```

---

#### Active State (Click)

**Behavior:**
- Scale down: `scale-95` (5% shrink)
- Background darkens more: `bg-primary/80`
- Duration: 100ms
- No shadow (pressed in)

**Why:**
- Mimics physical button press
- Satisfying tactile feedback
- Confirms click registered

**Code:**
```css
.button:active {
  transform: scale(0.95) translateY(0);
  box-shadow: none;
}
```

---

#### Focus State (Keyboard)

**Behavior:**
- Focus ring appears: `ring-2 ring-primary ring-offset-2`
- Ring is 2px solid, 2px offset
- No other changes (hover separate)

**Why:**
- Keyboard accessibility (WCAG 2.1)
- Clearly shows tab focus position
- Doesn't interfere with hover

**Code:**
```css
.button:focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px hsl(var(--background)),
              0 0 0 4px hsl(var(--primary));
}
```

---

#### Loading State

**Behavior:**
- Button disabled: `opacity-50 cursor-not-allowed`
- Text changes: "Create Mind" → "Creating..."
- Spinner appears (left of text)
- Width remains constant (prevents layout shift)

**Visual:**
```
[○ Creating...]  ← Spinner rotates 360° every 1s
```

**Code:**
```tsx
<Button disabled className="relative">
  {isLoading && (
    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
  )}
  {isLoading ? 'Creating...' : 'Create Mind'}
</Button>
```

**Animation:**
```css
@keyframes spin {
  to { transform: rotate(360deg); }
}
.animate-spin {
  animation: spin 1s linear infinite;
}
```

---

#### Success State (Temporary)

**Behavior:**
- Background: `bg-success` (green)
- Icon: Checkmark appears
- Duration: 2 seconds
- Then reverts to idle or changes text

**Visual:**
```
[✓ Created!]  → (2s) → [View Mind]
```

**Code:**
```tsx
const [success, setSuccess] = useState(false);

const handleCreate = async () => {
  await createMind();
  setSuccess(true);
  setTimeout(() => setSuccess(false), 2000);
};

<Button className={success ? "bg-success" : "bg-primary"}>
  {success && <Check className="mr-2 h-4 w-4" />}
  {success ? 'Created!' : 'Create Mind'}
</Button>
```

---

### Card Hover Effects

#### Standard Card

**Idle:**
- Background: `bg-card`
- Border: `border-border` (1px solid)
- Shadow: None

**Hover:**
- Shadow lifts: `shadow-lg` (8px elevation)
- Border color: `border-primary/50`
- Cursor: `cursor-pointer`
- Transform: `translateY(-2px)` (subtle lift)
- Transition: 300ms ease-out

**Code:**
```css
.card {
  transition: all 300ms ease-out;
}
.card:hover {
  box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1);
  border-color: hsl(var(--primary) / 0.5);
  transform: translateY(-2px);
}
```

**Why:**
- Indicates card is clickable (entire card = link)
- Creates depth perception
- Smooth, polished feel

---

#### Mind Card (Special)

**Additional Behaviors:**
- **Idle:** Fidelity score badge (colored)
- **Hover:**
  - Badge pulses once (scale 1 → 1.1 → 1)
  - Quick preview tooltip appears (300ms delay)
  - "View Details →" arrow slides in from right

**Preview Tooltip:**
```
┌─────────────────────────────┐
│ João Lozano                 │
│ ──────────────────────────  │
│ Fidelity: 98%               │
│ Fragments: 1,203            │
│ Last updated: 2h ago        │
│                             │
│ Expertise:                  │
│ • Leadership ⭐⭐⭐          │
│ • Innovation ⭐⭐⭐          │
│ • Product ⭐⭐              │
└─────────────────────────────┘
```

**Code:**
```tsx
<Card className="group relative">
  <CardContent>
    {/* Card content */}
  </CardContent>

  {/* Hover-only tooltip */}
  <div className="
    absolute top-0 right-0
    opacity-0 group-hover:opacity-100
    transition-opacity duration-300
    pointer-events-none
  ">
    <Tooltip content={<MindPreview mind={mind} />} />
  </div>

  {/* Slide-in arrow */}
  <div className="
    translate-x-4 opacity-0
    group-hover:translate-x-0 group-hover:opacity-100
    transition-all duration-300
  ">
    View Details →
  </div>
</Card>
```

---

### Toggle Switches

**Use Case:** On/off binary states
- Mind status: Active / Paused
- Email notifications: On / Off
- Dark mode: Light / Dark

**Visual Specs:**
- Width: 44px
- Height: 24px
- Thumb: 20px circle
- Padding: 2px

**States:**

#### Off (Inactive)
```
[  ○ ]  Background: gray-300, Thumb: white
```

#### On (Active)
```
[ ○  ]  Background: primary, Thumb: white
```

**Animation:**
- Thumb slides: `translate-x-0` → `translate-x-20px`
- Duration: 200ms ease-in-out
- Background color fades: 200ms

**Code:**
```tsx
<Switch
  checked={isActive}
  onCheckedChange={setIsActive}
  className="
    w-11 h-6
    bg-gray-300 data-[state=checked]:bg-primary
    transition-colors duration-200
  "
>
  <SwitchThumb className="
    w-5 h-5
    translate-x-0 data-[state=checked]:translate-x-5
    transition-transform duration-200
  " />
</Switch>
```

**Accessibility:**
- Role: `role="switch"`
- State: `aria-checked="true|false"`
- Label: `aria-label="Toggle mind status"`
- Keyboard: Space bar toggles

---

### Dropdown Menus

#### Trigger Button

**Visual:**
```
[Filter ▾]  ← Chevron indicates dropdown
```

**Hover:**
- Background: `bg-secondary`
- Chevron rotates: 0deg → 180deg (when open)

#### Menu Open Animation

**Behavior:**
1. Menu appears below trigger (100ms fade-in)
2. Slight scale-up: `scale-95` → `scale-100`
3. Origin: Top-center (grows downward)

**Code:**
```tsx
<DropdownMenu>
  <DropdownMenuTrigger asChild>
    <Button variant="outline">
      Filter
      <ChevronDown className="ml-2 h-4 w-4 transition-transform" />
    </Button>
  </DropdownMenuTrigger>

  <DropdownMenuContent className="
    animate-in fade-in-0 zoom-in-95
    slide-in-from-top-2
    duration-100
  ">
    <DropdownMenuItem>Active</DropdownMenuItem>
    <DropdownMenuItem>Draft</DropdownMenuItem>
    <DropdownMenuItem>Paused</DropdownMenuItem>
  </DropdownMenuContent>
</DropdownMenu>
```

**Animation Classes (Tailwind):**
```css
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}
@keyframes zoomIn {
  from { transform: scale(0.95); }
  to { transform: scale(1); }
}
@keyframes slideInFromTop {
  from { transform: translateY(-8px); }
  to { transform: translateY(0); }
}
```

---

## Animation Guidelines

### Animation Duration Scale

| Duration | Use Case | Example |
|----------|----------|---------|
| **50-100ms** | Instant feedback | Button click, checkbox toggle |
| **200-300ms** | Quick transitions | Dropdown open, tooltip appear |
| **300-500ms** | Page transitions | Route change, modal open |
| **500-1000ms** | Emphasis animations | Success celebration, onboarding |
| **>1000ms** | Loading states | Skeleton loaders, spinners |

**Rule:** Faster animations feel snappier, but too fast (< 50ms) feels jarring.

---

### Easing Functions

**Linear** (`linear`)
- Constant speed
- Use for: Continuous animations (spinners, progress bars)

**Ease-out** (`ease-out`)
- Fast start, slow end
- Use for: Things entering the screen (modals, tooltips)
- Most common

**Ease-in** (`ease-in`)
- Slow start, fast end
- Use for: Things exiting the screen (closing modals)

**Ease-in-out** (`ease-in-out`)
- Slow start, fast middle, slow end
- Use for: Transformations (expand/collapse)

**Cubic Bezier** (`cubic-bezier(0.4, 0, 0.2, 1)`)
- Custom curves
- Use for: Branded animations, special effects

**Code Examples:**
```css
/* Quick interactions */
button { transition: all 200ms ease-out; }

/* Modal opening (ease-out) */
.modal { animation: slideIn 300ms ease-out; }

/* Modal closing (ease-in) */
.modal-exit { animation: slideOut 300ms ease-in; }

/* Accordion (ease-in-out) */
.accordion { transition: height 400ms ease-in-out; }
```

---

### Animation Best Practices

**✅ DO:**
- Animate opacity (cheap, GPU-accelerated)
- Animate transform (scale, translate, rotate)
- Use CSS transitions for simple interactions
- Use Framer Motion for complex orchestrations
- Test on low-end devices (reduce motion if slow)

**❌ DON'T:**
- Animate width/height directly (causes reflow)
- Animate color (expensive, use opacity instead)
- Chain 5+ animations (overwhelming)
- Animate on every mouse move (performance)
- Ignore `prefers-reduced-motion` (accessibility)

**Performance Optimization:**
```css
/* Instead of animating width: */
❌ .box { transition: width 300ms; }

/* Animate scale: */
✅ .box { transition: transform 300ms; }

/* Instead of animating background-color: */
❌ .button { transition: background-color 300ms; }

/* Animate opacity of overlay: */
✅ .button::before {
     opacity: 0;
     transition: opacity 300ms;
   }
   .button:hover::before {
     opacity: 0.1;
   }
```

---

### Reduced Motion (Accessibility)

**Media Query:**
```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

**React Implementation:**
```tsx
const prefersReducedMotion = window.matchMedia(
  '(prefers-reduced-motion: reduce)'
).matches;

const animationDuration = prefersReducedMotion ? 0 : 300;

<motion.div
  initial={{ opacity: 0 }}
  animate={{ opacity: 1 }}
  transition={{ duration: animationDuration / 1000 }}
>
  Content
</motion.div>
```

---

## Feedback Mechanisms

### Toast Notifications

**Use Case:** Non-blocking feedback for actions

**Types:**

#### Success Toast
```
┌───────────────────────────────────┐
│ ✓ Mind created successfully!      │
└───────────────────────────────────┘
```
- Background: `bg-success` (green)
- Icon: Checkmark
- Duration: 3 seconds
- Position: Top-right
- Auto-dismiss: Yes

#### Error Toast
```
┌───────────────────────────────────┐
│ ✕ Failed to create mind           │
│ [Retry] [View Details]            │
└───────────────────────────────────┘
```
- Background: `bg-error` (red)
- Icon: X mark
- Duration: 5 seconds (longer)
- Actions: Retry button
- Auto-dismiss: No (user must dismiss)

#### Info Toast
```
┌───────────────────────────────────┐
│ ℹ Pipeline will take ~45 minutes  │
└───────────────────────────────────┘
```
- Background: `bg-info` (blue)
- Icon: Info circle
- Duration: 4 seconds
- Auto-dismiss: Yes

**Animation:**
1. **Enter:** Slide in from right (300ms ease-out)
2. **Stay:** 3-5 seconds (progress bar shrinks)
3. **Exit:** Fade out + slide right (200ms ease-in)

**Code:**
```tsx
import { toast } from 'sonner';

// Success
toast.success('Mind created successfully!', {
  duration: 3000,
});

// Error
toast.error('Failed to create mind', {
  duration: 5000,
  action: {
    label: 'Retry',
    onClick: () => retryCreate(),
  },
});

// Loading (with promise)
toast.promise(createMind(), {
  loading: 'Creating mind...',
  success: 'Mind created!',
  error: 'Failed to create mind',
});
```

**Positioning:**
```tsx
<Toaster
  position="top-right"
  toastOptions={{
    className: 'bg-card border-border',
    duration: 3000,
  }}
/>
```

---

### Inline Validation

**Use Case:** Form field errors

**Behavior:**
- **Validation timing:** On blur (not on every keystroke)
- **Error display:** Below field, red text
- **Icon:** Red X next to field
- **Border:** Red highlight

**Example:**
```
Name *
[João Lozano_________]

Slug *
[joão lozano_________] ✕
└─ Slug can only contain lowercase letters, numbers, and hyphens
```

**States:**

| State | Border | Icon | Message |
|-------|--------|------|---------|
| Default | `border-input` | None | None |
| Focused | `border-primary ring-2` | None | None |
| Valid | `border-success` | ✓ Green | None |
| Invalid | `border-error` | ✕ Red | Error text below |

**Code:**
```tsx
<FormField
  control={form.control}
  name="slug"
  render={({ field, fieldState }) => (
    <FormItem>
      <FormLabel>Slug</FormLabel>
      <FormControl>
        <div className="relative">
          <Input
            {...field}
            className={cn(
              fieldState.error && "border-error",
              fieldState.isDirty && !fieldState.error && "border-success"
            )}
          />
          {fieldState.error && (
            <X className="absolute right-3 top-3 h-4 w-4 text-error" />
          )}
          {fieldState.isDirty && !fieldState.error && (
            <Check className="absolute right-3 top-3 h-4 w-4 text-success" />
          )}
        </div>
      </FormControl>
      <FormMessage />
    </FormItem>
  )}
/>
```

---

### Progress Indicators

#### Linear Progress Bar

**Use Case:** File uploads, job phases

**Visual:**
```
[████████░░░░░░░░] 45%
```

**Anatomy:**
- Track: Full width, `bg-secondary`
- Fill: Animated width, `bg-primary`
- Label: Percentage (optional)

**Animation:**
- Fill width: Smooth transition, 300ms ease-out
- Indeterminate mode: Slide left-to-right (loading)

**Code:**
```tsx
<Progress value={45} className="w-full" />

{/* Indeterminate (unknown duration) */}
<Progress value={undefined} className="w-full">
  <ProgressIndicator className="animate-pulse" />
</Progress>
```

---

#### Circular Progress (Spinner)

**Use Case:** Button loading, page loading

**Visual:**
```
  ○
 ╱ ╲   ← Spins 360° continuously
╱   ╲
```

**Specs:**
- Size: 16px (small), 24px (medium), 32px (large)
- Stroke: 2px
- Color: `text-primary` or `text-muted-foreground`
- Speed: 1 rotation per second

**Code:**
```tsx
<Loader2 className="h-6 w-6 animate-spin text-primary" />
```

---

#### Skeleton Loaders

**Use Case:** Page loading (perceived performance)

**Visual:**
```
┌─────────────────────────────────┐
│ ████░░░░░░░░░                   │ ← Title
│ ░░░░░░░░░░░░░░                  │ ← Subtitle
│                                 │
│ ████████░░░░░░░░░░░░░░░        │ ← Paragraph
│ ░░░░░░░░░░░░░░░░░░░░░░░░░      │
└─────────────────────────────────┘
```

**Animation:**
- Shimmer effect: Left to right gradient
- Duration: 2 seconds loop
- Colors: `bg-muted` → `bg-muted/50` → `bg-muted`

**Code:**
```tsx
<div className="space-y-4">
  <Skeleton className="h-8 w-3/4" />  {/* Title */}
  <Skeleton className="h-4 w-1/2" />  {/* Subtitle */}
  <Skeleton className="h-32 w-full" /> {/* Content */}
</div>
```

**Shimmer CSS:**
```css
@keyframes shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}

.skeleton {
  background: linear-gradient(
    90deg,
    hsl(var(--muted)) 0%,
    hsl(var(--muted) / 0.5) 50%,
    hsl(var(--muted)) 100%
  );
  background-size: 200% 100%;
  animation: shimmer 2s ease-in-out infinite;
}
```

---

## Progressive Disclosure

### Concept

**Definition:** Show only what's necessary, reveal complexity on demand.

**Benefits:**
- Reduces cognitive load
- Faster initial understanding
- Power users can dive deep
- Cleaner UI

---

### Pattern 1: Expandable Sections (Accordion)

**Use Case:** Long forms, FAQ, settings

**Example:**
```
┌────────────────────────────────┐
│ Basic Information        [▼]   │
├────────────────────────────────┤
│ Name: João Lozano              │
│ Slug: joao_lozano              │
│ Status: Active                 │
└────────────────────────────────┘

┌────────────────────────────────┐
│ Advanced Settings        [▶]   │ ← Collapsed
└────────────────────────────────┘
```

**Interaction:**
- Click header to expand/collapse
- Icon rotates: ▶ (closed) ↔ ▼ (open)
- Content slides down (400ms ease-in-out)
- Only one section open at a time (accordion mode)

**Code:**
```tsx
<Accordion type="single" collapsible>
  <AccordionItem value="basic">
    <AccordionTrigger>Basic Information</AccordionTrigger>
    <AccordionContent>
      {/* Form fields */}
    </AccordionContent>
  </AccordionItem>

  <AccordionItem value="advanced">
    <AccordionTrigger>Advanced Settings</AccordionTrigger>
    <AccordionContent>
      {/* Advanced fields */}
    </AccordionContent>
  </AccordionItem>
</Accordion>
```

---

### Pattern 2: "Show More" Button

**Use Case:** Long lists, text truncation

**Example:**
```
Recent Jobs (Showing 5 of 47)
├─ Job #12345: João Lozano (Success)
├─ Job #12346: Maria Silva (Running)
├─ Job #12347: Steve Jobs (Success)
├─ Job #12348: Pedro Vale... (Failed)
└─ Job #12349: Brené Brown (Success)

[Show More (42 remaining)]
```

**Interaction:**
- Click "Show More" → Loads next 10
- Button updates: "Show More (32 remaining)"
- Smooth scroll to new items
- When all loaded: Button becomes "Scroll to Top"

**Code:**
```tsx
const [visibleCount, setVisibleCount] = useState(5);
const remainingCount = jobs.length - visibleCount;

<div className="space-y-2">
  {jobs.slice(0, visibleCount).map(job => (
    <JobCard key={job.id} job={job} />
  ))}
</div>

{remainingCount > 0 && (
  <Button
    variant="outline"
    onClick={() => setVisibleCount(prev => prev + 10)}
  >
    Show More ({remainingCount} remaining)
  </Button>
)}
```

---

### Pattern 3: Tooltips (On Hover)

**Use Case:** Explain jargon, provide context

**Example:**
```
Fidelity Score: 94% [ℹ]
                    ↓ (hover)
┌────────────────────────────────────┐
│ Fidelity measures how accurately   │
│ the mind replicates the original   │
│ person's thinking patterns.        │
│                                    │
│ 90%+ = Production-ready            │
│ 85-90% = Review needed             │
│ <85% = More sources required       │
└────────────────────────────────────┘
```

**Specs:**
- Trigger: Hover (300ms delay) or focus (keyboard)
- Position: Smart positioning (avoid screen edges)
- Width: Max 300px
- Arrow: Points to trigger element

**Code:**
```tsx
<Tooltip>
  <TooltipTrigger asChild>
    <div className="inline-flex items-center">
      Fidelity Score: 94%
      <Info className="ml-1 h-4 w-4 text-muted-foreground" />
    </div>
  </TooltipTrigger>
  <TooltipContent className="max-w-xs">
    <p>Fidelity measures how accurately the mind replicates...</p>
  </TooltipContent>
</Tooltip>
```

---

## Data Visualization

### Chart Color Palette

**Primary Data Colors:**
```
Primary:   #3b82f6 (blue)
Success:   #10b981 (green)
Warning:   #f59e0b (orange)
Error:     #ef4444 (red)
Info:      #8b5cf6 (purple)
Neutral:   #6b7280 (gray)
```

**Multi-Series Palette (Categorical Data):**
```
Series 1:  #3b82f6 (blue)
Series 2:  #10b981 (green)
Series 3:  #f59e0b (orange)
Series 4:  #8b5cf6 (purple)
Series 5:  #ec4899 (pink)
Series 6:  #14b8a6 (teal)
```

**Gradient (Sequential Data):**
```
Low:       #dbeafe (light blue)
Medium:    #3b82f6 (blue)
High:      #1e40af (dark blue)
```

---

### Line Chart (Fidelity Trends)

**Use Case:** Show metrics over time

**Visual:**
```
Fidelity Score (Last 30 Days)
100% ┼─────────────────────────────
     │         ╱─────╲
 90% ┼────────╱       ╲
     │       ╱         ╲_____
 80% ┼──────╱
     │
 70% ┼─────────────────────────────
     └────────────────────────────
     Nov 1           Nov 15   Nov 30
```

**Interactions:**
- **Hover:** Show tooltip with exact value
- **Click:** Drill down to that day's details
- **Zoom:** Pinch/scroll to zoom time range
- **Pan:** Drag to shift time window

**Tooltip:**
```
┌─────────────────────┐
│ November 15, 2025   │
│ Fidelity: 94.2%     │
│                     │
│ ↑ +2.3% from Nov 14 │
└─────────────────────┘
```

**Code (Recharts):**
```tsx
<ResponsiveContainer width="100%" height={300}>
  <LineChart data={fidelityData}>
    <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
    <XAxis
      dataKey="date"
      stroke="hsl(var(--muted-foreground))"
    />
    <YAxis
      domain={[70, 100]}
      stroke="hsl(var(--muted-foreground))"
    />
    <Tooltip content={<CustomTooltip />} />
    <Line
      type="monotone"
      dataKey="fidelity"
      stroke="hsl(var(--primary))"
      strokeWidth={2}
      dot={{ r: 4 }}
      activeDot={{ r: 6 }}
    />
  </LineChart>
</ResponsiveContainer>
```

---

### Radar Chart (Trait Distribution)

**Use Case:** Show multi-dimensional profiles

**Visual:**
```
      Communication (8/10)
            /\
           /  \
          /    \
    Values      Identity
    (9/10)      (10/10)
         \      /
          \    /
           \  /
        Cognition
         (7/10)
```

**Interactions:**
- **Hover axis:** Highlight that trait, show description
- **Click axis:** Drill into trait details
- **Compare:** Overlay multiple minds (semi-transparent)

**Color Coding:**
- Ideal range (green zone): 8-10
- Acceptable range (yellow zone): 6-8
- Needs improvement (red zone): <6

---

### Bar Chart (Quality Breakdown)

**Use Case:** Compare discrete categories

**Visual:**
```
Quality Score by Phase

Research      ████████████░░  90%
Analysis      ██████████████  95%
Synthesis     ███████████░░░  88%
Implementation███████████████  97%
Validation    █████████████░  92%

             0%  25%  50%  75%  100%
```

**Interactions:**
- **Hover bar:** Show exact percentage + count
- **Click bar:** Filter table to that phase's data
- **Sort:** Click axis label to reorder

---

## Form Interactions

### Multi-Step Form (Wizard)

**Use Case:** Create Mind (3 steps)

**Progress Indicator:**
```
○───────○───────○
1       2       3
Basic   Sources Review
  ✓              ← Current step
```

**Navigation:**
- **Next button:** Validates current step before proceeding
- **Back button:** Always available, no validation
- **Step numbers clickable:** Only if step already visited
- **Progress saved:** Auto-save on blur, restore on return

**Code:**
```tsx
<Form {...form}>
  <FormProgress currentStep={step} totalSteps={3} />

  {step === 1 && <BasicInfoStep />}
  {step === 2 && <SourcesStep />}
  {step === 3 && <ReviewStep />}

  <FormNavigation
    onBack={() => setStep(step - 1)}
    onNext={handleNext}
    canGoBack={step > 1}
    canGoNext={form.formState.isValid}
  />
</Form>
```

---

### Autosave Indicator

**Visual:**
```
[Input field_____________] ✓ Saved (2s ago)
                            ↓ While typing
[Input field_____________] ○ Saving...
                            ↓ After pause
[Input field_____________] ✓ Saved (just now)
```

**Behavior:**
- **Typing:** Show "○ Saving..." (pulsing)
- **300ms after typing stops:** Trigger autosave
- **On success:** "✓ Saved (just now)"
- **On error:** "✕ Failed to save (Retry)"

**Code:**
```tsx
const [saveStatus, setSaveStatus] = useState<'idle' | 'saving' | 'saved' | 'error'>('idle');

const debouncedSave = useDebouncedCallback(
  async (value) => {
    setSaveStatus('saving');
    try {
      await saveDraft(value);
      setSaveStatus('saved');
      setTimeout(() => setSaveStatus('idle'), 2000);
    } catch (error) {
      setSaveStatus('error');
    }
  },
  300 // Wait 300ms after typing stops
);

<Input
  onChange={(e) => {
    debouncedSave(e.target.value);
  }}
/>
<span className="text-sm text-muted-foreground">
  {saveStatus === 'saving' && '○ Saving...'}
  {saveStatus === 'saved' && '✓ Saved just now'}
  {saveStatus === 'error' && '✕ Failed to save'}
</span>
```

---

## Real-Time Updates

### WebSocket Connection Indicator

**Visual:**
```
Top-right corner:
● Connected       (green dot, pulsing)
● Connecting...   (yellow dot, pulsing)
● Disconnected    (red dot, static)
```

**Behavior:**
- **Connected:** Auto-hide after 3 seconds
- **Disconnected:** Show banner: "Connection lost. Retrying..."
- **Reconnected:** Show toast: "✓ Reconnected"

---

### Live Data Updates

**Pattern:** Optimistic UI

**Example:** User pauses a mind

1. **User clicks "Pause"**
   - UI updates immediately (optimistic)
   - Status badge: Active → Paused (grayed out)
   - Button disabled during API call

2. **API call in progress**
   - Spinner on button
   - Tooltip: "Pausing..."

3. **API success**
   - Remove spinner
   - Toast: "✓ Mind paused"
   - Enable button (now shows "Resume")

4. **API failure**
   - Revert UI change (Paused → Active)
   - Toast: "✕ Failed to pause mind"
   - Button re-enabled
   - Retry button available

**Code:**
```tsx
const [status, setStatus] = useState(mind.status);
const [isPending, setIsPending] = useState(false);

const handlePause = async () => {
  // Optimistic update
  const previousStatus = status;
  setStatus('paused');
  setIsPending(true);

  try {
    await pauseMind(mind.id);
    toast.success('Mind paused');
  } catch (error) {
    // Revert on failure
    setStatus(previousStatus);
    toast.error('Failed to pause mind', {
      action: { label: 'Retry', onClick: handlePause }
    });
  } finally {
    setIsPending(false);
  }
};
```

---

## Error Prevention & Recovery

### Confirmation Dialogs (Destructive Actions)

**Use Case:** Delete mind, cancel job

**Visual:**
```
┌─────────────────────────────────────┐
│ Delete Mind?                    [X] │
├─────────────────────────────────────┤
│                                     │
│ Are you sure you want to delete     │
│ João Lozano?                        │
│                                     │
│ This will permanently remove:       │
│ • Mind profile                      │
│ • 1,203 knowledge fragments         │
│ • System prompts                    │
│ • Job execution history             │
│                                     │
│ This action cannot be undone.       │
│                                     │
│ [Cancel]  [Delete Mind]             │
└─────────────────────────────────────┘
```

**Interaction:**
- **Trigger:** Click "Delete" button
- **Modal blocks UI:** Focus trap
- **Escape key:** Closes modal (safe default)
- **Delete button:** Red, requires confirmation
- **Optional:** Type mind name to confirm

**Extra Protection (High-Risk Actions):**
```
To confirm, type the mind name: João Lozano

[________________]  ← Must match exactly

[Cancel]  [Delete Mind (disabled until typed)]
```

**Code:**
```tsx
<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="destructive">Delete Mind</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogHeader>
      <AlertDialogTitle>Delete Mind?</AlertDialogTitle>
      <AlertDialogDescription>
        Are you sure you want to delete {mind.name}?
        This action cannot be undone.
      </AlertDialogDescription>
    </AlertDialogHeader>
    <AlertDialogFooter>
      <AlertDialogCancel>Cancel</AlertDialogCancel>
      <AlertDialogAction
        onClick={handleDelete}
        className="bg-error"
      >
        Delete Mind
      </AlertDialogAction>
    </AlertDialogFooter>
  </AlertDialogContent>
</AlertDialog>
```

---

### Undo Actions

**Use Case:** Accidental deletes, bulk actions

**Pattern:** Toast with undo button

**Example:**
```
┌────────────────────────────────────┐
│ ✓ 3 minds paused  [Undo]           │
└────────────────────────────────────┘
  ↓ (5 seconds)
  Auto-dismiss (action committed)
```

**Behavior:**
- Show toast immediately after action
- Undo button available for 5 seconds
- If clicked: Revert action, show "Undone" toast
- If timeout: Action committed permanently

**Code:**
```tsx
const handleBulkPause = async (mindIds: string[]) => {
  // Pause minds
  await pauseMinds(mindIds);

  // Show undo toast
  toast.success(`${mindIds.length} minds paused`, {
    duration: 5000,
    action: {
      label: 'Undo',
      onClick: async () => {
        await resumeMinds(mindIds);
        toast.success('Undone');
      },
    },
  });
};
```

---

## Accessibility Interactions

### Keyboard Navigation

**Tab Order:**
1. Skip to content link (hidden until focused)
2. Logo (home link)
3. Search bar
4. Primary navigation (sidebar)
5. Page content (headings, links, buttons)
6. Modals (trap focus inside)

**Keyboard Shortcuts:**
- `Tab`: Next focusable element
- `Shift+Tab`: Previous element
- `Enter` / `Space`: Activate button/link
- `Esc`: Close modal/dropdown
- `Arrow keys`: Navigate dropdowns, tabs
- `/`: Focus search bar
- `?`: Show keyboard shortcuts help

---

### Focus Management

**Focus Indicators:**
```css
*:focus-visible {
  outline: 2px solid hsl(var(--primary));
  outline-offset: 2px;
  border-radius: 4px;
}
```

**Focus Trap (Modals):**
- When modal opens: Focus first interactive element
- Tab cycles only within modal
- Esc closes modal, returns focus to trigger
- On close: Restore focus to button that opened modal

**Code:**
```tsx
<Dialog>
  <DialogTrigger ref={triggerRef}>Open</DialogTrigger>
  <DialogContent
    onOpenAutoFocus={(e) => {
      // Focus first input instead of close button
      e.preventDefault();
      firstInputRef.current?.focus();
    }}
    onCloseAutoFocus={() => {
      // Return focus to trigger button
      triggerRef.current?.focus();
    }}
  >
    {/* Modal content */}
  </DialogContent>
</Dialog>
```

---

### Screen Reader Announcements

**Live Regions:**
```tsx
{/* Announce status changes */}
<div
  role="status"
  aria-live="polite"
  aria-atomic="true"
  className="sr-only"
>
  {status === 'loading' && 'Creating mind...'}
  {status === 'success' && 'Mind created successfully'}
  {status === 'error' && 'Failed to create mind'}
</div>
```

**ARIA Labels:**
```tsx
{/* Icon buttons need labels */}
<Button aria-label="Close dialog">
  <X className="h-4 w-4" />
</Button>

{/* Form inputs need labels (even if visually hidden) */}
<label htmlFor="search" className="sr-only">
  Search minds
</label>
<Input
  id="search"
  placeholder="Search..."
  aria-describedby="search-help"
/>
<span id="search-help" className="sr-only">
  Search by name, slug, or expertise area
</span>
```

---

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-10-29 | 1.0 | Initial interaction design patterns | Sally (UX Expert) |

---

**Previous:** [← 13. User Flows & Journey Maps](./13-user-flows.md)
**Back to Index:** [📋 README](./README.md)
