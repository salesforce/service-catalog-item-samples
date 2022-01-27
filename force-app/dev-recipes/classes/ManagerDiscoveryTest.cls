@isTest
public class ManagerDiscoveryTest {
    @isTest
    public static void testGetManagerWithInvalidFieldThrowsException() {
        boolean exceptionIsCaught = false;
        try {
            ManagerDiscovery.getManagerId(new List<String>{ 'DUMMY_FIELD' });
        } catch (ManagerDiscovery.InvalidFieldException e) {
            exceptionIsCaught = true;
        }

        System.assert(exceptionIsCaught, 'Exception should have been thrown');
    }

    @isTest
    public static void testGetManagerWithNotManagerReturnsNull() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User u = new User(
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'standarduser' +
                DateTime.now().getTime() +
                '@testorg.com'
        );

        System.runAs(u) {
            List<String> results = ManagerDiscovery.getManagerId(
                new List<String>{ 'ManagerId' }
            );

            System.assertEquals(
                1,
                results.size(),
                'One result should still have been returned'
            );
            System.assertEquals(
                null,
                results.get(0),
                'Manager Field should have been null'
            );
        }
    }

    @isTest
    public static void testGetManagerWithManagerSetReturnsManagerId() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User manager = new User(
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'manager' + DateTime.now().getTime() + '@testorg.com'
        );

        insert manager;

        User u = new User(
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'managee' + DateTime.now().getTime() + '@testorg.com',
            ManagerId = manager.Id
        );

        System.runAs(u) {
            List<String> results = ManagerDiscovery.getManagerId(
                new List<String>{ 'ManagerId' }
            );

            System.assertEquals(
                1,
                results.size(),
                'One result should have been returned'
            );
            System.assertNotEquals(
                null,
                results.get(0),
                'Manager Field should have been null'
            );
        }
    }
}
