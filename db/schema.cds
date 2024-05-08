namespace templates;

using { managed } from '@sap/cds/common';

type Identifier: String(3);
type countryId: String(2);
type amount: Decimal(7, 2);
type ValidityStatus: Int16 enum {
  Available = 1 @description: '{i18n>ValidityStatusAvailable}' @title: '{i18n>ValidityStatusAvailable}';
  NotAvailable = 2 @description: '{i18n>ValidityStatusNotAvailable}' @title: '{i18n>ValidityStatusNotAvailable}';
};

type Criticality: Integer enum {
    NotCritical = 1 @description: '{i18n>criticalityNotCritical}' @title: '{i18n>criticalityNotCritical}';
    Critical = 2 @description: '{i18n>criticalityCritical}' @title: '{i18n>criticalityCritical}';
    HighlyCritical = 3 @description: '{i18n>criticalityHighlyCritical}' @title: '{i18n>criticalityHighlyCritical}';
};

entity Category: managed {
    key id: Identifier;
    text: String;
    status: ValidityStatus;
    validTo: Timestamp;
    to_country: Association to Country;
    to_templates: Composition of many Template on to_templates.to_category = $self;
}

entity Template: managed {
    key id: Identifier;
    text: String;
    validTo: Date;
    amountOfPurchase: amount;
    criticality: Criticality;
    to_category: Association to Category;
}

entity Country {
    key id: Integer;
    code: countryId;
    text: String;
    to_category: Association to many Category
}