using IncidentService as service from '../../srv/incidentservice';
using from '../annotations';

annotate service.Incidents with {
    assignedIndividual @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Individual',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: assignedIndividual_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'fullName',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'emailAddress',
            },
        ],
    }
};

annotate service.Incidents with @(
    UI.SelectionFields               : [
        incidentStatus_code,
        priority_code,
        category_code,
        identifier,
    ],
    UI.LineItem                      : [
        {
            $Type             : 'UI.DataFieldForAction',
            Action            : 'IncidentService.process_status',
            Label             : 'Process Status',
            InvocationGrouping: #ChangeSet
        },
        {
            $Type            : 'UI.DataField',
            Value            : identifier,
            ![@UI.Importance]: #High,
        },
        {
            $Type                    : 'UI.DataField',
            Value                    : priority_code,
            Criticality              : priority.criticality,
            CriticalityRepresentation: #WithoutIcon,
        },
        {
            $Type: 'UI.DataField',
            Value: incidentStatus_code,
        },
        {
            $Type: 'UI.DataField',
            Value: category_code,
        },
        {
            $Type: 'UI.DataField',
            Value: title,
        },
    ],
    UI.FieldGroup #IncidentDetails   : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: identifier,
            },
            {
                $Type: 'UI.DataField',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Value: description,
            },
        ],
    },
    UI.Facets                        : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>IncidentOverview}',
            ID    : 'IncidentOverviewFacet',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>IncidentDetails}',
                    ID    : 'IncidentDetailsFacet',
                    Target: '@UI.FieldGroup#IncidentDetails',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'General Information',
                    ID    : 'GeneralInformation',
                    Target: '@UI.FieldGroup#GeneralInformation',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>IncidentProcessFlow}',
            ID    : 'ProcessFlowFacet',
            Target: 'incidentFlow/@UI.LineItem',
        },
    ],
    UI.FieldGroup #GeneralInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: priority_code,
            },
            {
                $Type: 'UI.DataField',
                Value: category_code,
            },
            {
                $Type: 'UI.DataField',
                Value: incidentStatus_code,
            },
        ],
    },
);

annotate service.Incidents with {
    category @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Category',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: category_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'descr',
                },
            ],
        },
        Common.ValueListWithFixedValues: true
    )
};

annotate service.IncidentFlow with @(UI.LineItem: [
    {
        $Type      : 'UI.DataField',
        Value      : stepStatus,
        Criticality: criticality,
    },
    {
        $Type: 'UI.DataField',
        Value: processStep,
    },
    {
        $Type: 'UI.DataField',
        Value: stepStartDate,
    },
    {
        $Type: 'UI.DataField',
        Value: stepEndDate,
    },
    {
        $Type: 'UI.DataField',
        Value: incident.assignedIndividual.fullName,
        Label: '{i18n>CreatedBy}',
    },
]);
