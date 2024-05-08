using { CatalogService } from './service';

//1. Aggregation and analytical annotations
annotate CatalogService.GetTemplate with @(
  Aggregation.ApplySupported: {
    Transformations: [
      'aggregate',
      'topcount',
      'bottomcount',
      'identity',
      'concat',
      'groupby',
      'filter',
      'expand',
      'search'      
    ],
    GroupableProperties: [
        id,
        text,
        validTo,
        amountOfPurchase,
        criticality,
        amontAfterDiscount,
        amontOverTolerance,
        shouldBeFixedImmediately,
        to_category.to_country.text
    ],
    AggregatableProperties: [{
      $Type : 'Aggregation.AggregatablePropertyType',
      Property: amountOfPurchase
    }]
  },
  Analytics.AggregatedProperty #totalamount: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : amountOfPurchase,
    AggregationMethod : 'sum',
    Name : 'totalamout',
    ![@Common.Label]: 'Total purchase amount'
  },
);

//2. Main chart
annotate CatalogService.GetTemplate with @(
  UI.Chart: {
    $Type : 'UI.ChartDefinitionType',
    Title: 'Amount',
    ChartType : #Column,
    Dimensions: [
      criticality,    
      to_category.to_country.text
    ],
    DimensionAttributes: [{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: criticality,
      Role: #Category
    },{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: to_category.to_country.text,
      Role: #Category2
    }],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalamount]
    ],
    MeasureAttributes: [{
      $Type: 'UI.ChartMeasureAttributeType',
      DynamicMeasure: ![@Analytics.AggregatedProperty#totalamount],
      Role: #Axis1
    }]
  },
  UI.PresentationVariant: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart',
    ],
  }
);

//4. Selection Fields and Line Item
annotate CatalogService.GetTemplate with@(
    UI: {
        // SelectionFields  : [
        //     id,
        //     text,
        //     validTo,
        //     amountOfPurchase,
        //     criticality,
        //     amontAfterDiscount,
        //     amontOverTolerance,
        //     shouldBeFixedImmediately,
        //     to_category.to_country.text
        // ],
        LineItem: [
            {  $Type : 'UI.DataField', Value : id, },
            {  $Type : 'UI.DataField', Value : text, },
            {  $Type : 'UI.DataField', Value : validTo, },
            {  $Type : 'UI.DataField', Value : amountOfPurchase, },
            {  $Type : 'UI.DataField', Value : criticality, },
            {  $Type : 'UI.DataField', Value : to_category.to_country.code, },
            {  $Type : 'UI.DataField', Value : to_category.to_country.text, },
            {  $Type : 'UI.DataField', Value : amontAfterDiscount, },
            {  $Type : 'UI.DataField', Value : amontOverTolerance, },
            {  $Type : 'UI.DataField', Value : shouldBeFixedImmediately, }
        ],
    }
);