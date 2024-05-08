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
        }
}
