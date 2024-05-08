using templates as service from '../db/schema';


service CatalogService {
    @odata.draft.enabled
    @Capabilities: {
        Insertable: true,
        Deletable : true
    }
    entity GetCategory as
        projection on service.Category {
            *,
            null as numberOfTemplates : Integer,
        }
        excluding {
            createdBy,
            createdAt,
            modifiedBy,
            modifiedAt
        };

    entity GetTemplate as
        projection on service.Template {
            *,
            null as amontAfterDiscount : Integer,
            null as amontOverTolerance : Boolean,
            null as shouldBeFixedImmediately : Boolean
        }
        excluding {
            createdBy,
            createdAt,
            modifiedBy,
            modifiedAt
        }
}
