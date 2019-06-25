package com.gpnu.dao.impl;

import com.gpnu.dao.DraftDao;
import com.gpnu.domain.Draft;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class DraftDaoImpl implements DraftDao {

    @Resource(name = "hibernateTemplate")
    private HibernateTemplate hibernateTemplate;

    @Override
    public List<Draft> listDrafts() {
        List<Draft> draftList = (List<Draft>) hibernateTemplate.find("from Draft order by time desc");
        return draftList;
    }

    @Override
    public void updateDraft(Draft draft) {
        hibernateTemplate.update(draft);
    }

    @Override
    public Draft addDraft(Draft draft) {
        hibernateTemplate.save(draft);
        return draft;
    }

    @Override
    public void deleteDraft(Draft draft) {
        hibernateTemplate.delete(draft);
    }

    @Override
    public Draft findDraftById(Integer id) {
        return hibernateTemplate.get(Draft.class,id);
    }
}
