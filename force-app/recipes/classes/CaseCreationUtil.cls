/**
 * Supports Case creation in Fulfillment Flows used by the Service Catalog.
 */
public with sharing class CaseCreationUtil {
    /**
     * Saves the given Case record using a specific assignment rule.
     * If the given assignment rule cannot be retrieved, this method assigns a rule using the default active rule.
     * @param List of CreateCasePayload objects
     * @return List of Case IDs for the created Cases
     */
    @InvocableMethod(
        label='Create Case using Assignment Rules'
        description='Save the given Case record using a specific assignment rule. If the given assignment rule cannot be retrieved, assigns using default active rule. Returns Case Ids.'
    )
    public static List<String> createCaseAndAssignWithGivenRule(
        List<CreateCasePayload> ccps
    ) {
        List<String> outputIds = new List<String>();
        List<Case> caseList = new List<Case>();

        for (CreateCasePayload ccp : ccps) {
            String ruleName = ccp.ruleName;
            Case c = ccp.caseRecord;

            Database.DMLOptions dmo = new Database.DMLOptions();

            AssignmentRule ar = null;
            if (!String.isBlank(ruleName)) {
                // Get the assignment rule with the given name
                ar = [
                    SELECT Id, Name
                    FROM AssignmentRule
                    WHERE Name = :ruleName
                    LIMIT 1
                ];
            }

            if (ar != null) {
                // If we retrieved an assignment rule then use that ID
                dmo.assignmentRuleHeader.assignmentRuleId = ar.Id;
            } else {
                // Otherwise, use the default rule
                dmo.assignmentRuleHeader.useDefaultRule = true;
            }

            c.setOptions(dmo);
            caseList.add(c);
        }

        // Save the result to the database
        Database.SaveResult[] srs = Database.insert(caseList);
        for (Database.SaveResult sr : srs) {
            if (sr.isSuccess()) {
                outputIds.add(sr.getId());
            }
        }

        // Return the created Case IDs
        return outputIds;
    }

    public class CreateCasePayload {
        @InvocableVariable(required=true label='Case Record')
        public Case caseRecord;

        @InvocableVariable(required=false label='Assignment Rule Name')
        public String ruleName;
    }
}
