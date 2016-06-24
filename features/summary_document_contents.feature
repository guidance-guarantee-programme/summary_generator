Feature: Summary document contents
  As Pension Wise
  We want to provide a summary document
  So that customers are reminded of what was discussed, including next steps that they may wish to take

Scenario: Generic summary document
  Given we have captured the customer's details in an appointment summary
  When we preview their summary document
  Then the sections it includes should be (in order):
    | covering letter          |
    | getting started          |
    | options overview         |
    | detail about each option |
    | inheritance tax          |
    | scams                    |
    | further guidance         |

Scenario Outline: Supplementary information can be included
  Given the customer requires supplementary information about "<topic>"
  When we preview their summary document
  Then it should include supplementary information about "<topic>"

  Examples:
    | topic                                   |
    | Benefits and pension income             |
    | Debt and pensions                       |
    | Final salary or career average pensions |
    | Pensions and ill health                 |

Scenario: Records of guidance include the information provided to us by the customer
  Given we have captured the customer's details in an appointment summary
  When we preview their summary document
  Then the summary document should include their details

Scenario: Records of guidance include information about the appointment
  Given we have captured appointment details in an appointment summary
  When we preview their summary document
  Then the summary document should include the details of the appointment

@todo
Scenario: Reference numbers

@todo
Scenario: Page numbers
