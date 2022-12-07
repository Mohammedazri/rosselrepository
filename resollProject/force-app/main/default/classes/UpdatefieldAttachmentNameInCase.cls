// don t forget the documentation => 
public with sharing class UpdatefieldAttachmentNameInCase {
public static void updatefieldAttachmentNameInCaseMethode(String attachementName,Id pId) {
List<Case> cs = [select Id, attachment_name__c FROM case where Id=:pId];
// boocle foreach ?
/*
for(case csL:cs)
{
}
*/




cs[0].attachment_name__c=cs[0].attachment_name__c+' ; '+attachementName;
System.debug('attachmant name'+cs[0].attachment_name__c);
update cs[0];
}
}