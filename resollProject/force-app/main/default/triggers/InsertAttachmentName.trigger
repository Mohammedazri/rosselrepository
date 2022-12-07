trigger InsertAttachmentName on Attachment (after insert) {

if(Trigger.isAfter && Trigger.isInsert){
    // To-do : best practice no logic in the trigger 
String attachementName;
Id pId;
for(Attachment atta:trigger.new){
    attachementName=atta.name;
    pId=atta.ParentId;
}
    updatefieldAttachmentNameInCase.updatefieldAttachmentNameInCaseMethode(attachementName,pId);   
}
}