@IsTest
public with sharing class CaseCreationUtilTest {
    @IsTest
    public static void test_createCaseAndAssignWithGivenRule() {
        // Arrange
        Case caseRecord = new Case();
        caseRecord.Status = 'New';
        caseRecord.Origin = 'Phone';

        CaseCreationUtil.CreateCasePayload ccp = new CaseCreationUtil.CreateCasePayload();
        ccp.caseRecord = caseRecord;
        ccp.ruleName = '';

        List<CaseCreationUtil.CreateCasePayload> ccps = new List<CaseCreationUtil.CreateCasePayload>();
        ccps.add(ccp);

        // Act
        List<String> caseIds = CaseCreationUtil.createCaseAndAssignWithGivenRule(
            ccps
        );

        // Assert
        System.assertEquals(1, caseIds.size());
    }
}
