using scp.cloud from '../db/schema';

service IncidentService {

    @odata.draft.enabled
    entity Incidents               as projection on cloud.Incidents
        actions {
            action process_status();
        }

    action update_status(Idenfier : String  @UI.MultiLineText:true  @Common.Label:'Identifer'  );
    // action update_status(dataInicial : Date @Common.Label:'Start Date' );

    @readonly
    entity IncidentFlow            as projection on cloud.IncidentFlow;

    @readonly
    entity IncidentProcessTimeline as projection on cloud.IncidentProcessTimeline;

    @readonly
    entity Individual              as projection on cloud.Individual;

    @readonly
    entity Category                as projection on cloud.Category;

    @readonly
    entity Priority                as projection on cloud.Priority;


}
