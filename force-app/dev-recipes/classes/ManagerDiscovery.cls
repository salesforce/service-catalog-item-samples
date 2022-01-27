public with sharing class ManagerDiscovery {
    @InvocableMethod(
        label='Get ManagerId'
        description='Get ManagerId from specified field on User object'
    )
    public static List<String> getManagerId(List<String> fields) {
        List<String> results = new List<String>();

        Id userId = UserInfo.getUserId();

        Set<String> objectFields = Schema.SObjectType.User.fields.getMap()
            .keySet();

        for (String field : fields) {
            if (!objectFields.contains(field.toLowerCase())) {
                throw new InvalidFieldException('Invalid field: ' + field);
            }

            User managerUser = Database.query(
                'Select Id, ' +
                String.escapeSingleQuotes(field) +
                ' FROM User WHERE Id = :userId LIMIT 1'
            );

            if (managerUser != null) {
                results.add((String) managerUser.get(field));
            } else {
                results.add(null);
            }
        }

        return results;
    }

    public class InvalidFieldException extends Exception {
    }
}
