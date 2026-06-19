
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#let entry-list = (
  (
    key: "project",
    short: "Project",
    description: "A work item in the system, identified by an auto-generated number (year + running number, e.g. 26001). Has a name, optional project leader, and contains activities.",
  ),
  (
    key: "activity",
    short: "Activity",
    description: "A subdivision of a project (e.g. requirements, design, testing). Has budgeted time in hours, start/end week, and assigned employees.",
  ),
  (
    key: "employee",
    short: "Employee",
    description: "A developer at Softwarehuset A/S, identified by initials of up to 4 characters (e.g. 'huba'). Can work on multiple activities and be project leader.",
  ),
  (
    key: "project-leader",
    short: "Project Leader",
    description: "An employee assigned to lead a specific project. Responsible for dividing the project into activities and staffing them. Can be a regular employee on other projects.",
  ),
  (
    key: "time-registration",
    short: "Time Registration",
    description: "A record of time spent by an employee on an activity, with half-hour precision. Employees register daily.",
  ),
  (
    key: "budgeted-time",
    short: "Budgeted Time",
    description: "The expected number of work hours for an activity, set by the project leader.",
  ),
  (
    key: "fixed-activity",
    short: "Fixed Activity",
    description: "A non-project activity such as vacation, sick leave, or courses. Has a start and end date and is not billed to any project.",
  ),
  (
    key: "week-number",
    short: "Week Number",
    description: "The time resolution used for planning activities. Start and end times are specified as week numbers within a year (e.g. week 10 of 2026).",
  ),
  (
    key: "mvc",
    short: "Model–view–controller",
    description: "Model–view–controller (MVC) is a software architectural pattern commonly used for developing user interfaces that divides the related program logic into three interconnected elements. These elements are:

    the model, the internal representations of information
    the view, the interface that presents information to and accepts it from the user
    the controller, the software linking the two."
  ),
  (
    key: "javafx",
    short: "JavaFX",
    description: "JavaFX is a mature api for creating guis across platforms."
  ),
  (
    key: "cucumber-test",
    short: "Cucumber",
    description: "A framework for creating behaviour driven developoment bry writing tests like spoken english to bridge the gap between developers and customers."
  ),
  (
    key: "crud",
    short: "CRUD",
    description: "Create-Read-Update-Delete is a paradigm for api development where an api offers endpoints for creating resources, reading resources, updating resources, and deleting the resource."
  )
)