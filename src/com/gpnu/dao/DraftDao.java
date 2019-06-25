package com.gpnu.dao;

import com.gpnu.domain.Draft;

import java.util.List;

public interface DraftDao {
    public List<Draft> listDrafts();

    public void updateDraft(Draft draft);

    public Draft addDraft(Draft draft);

    public void deleteDraft(Draft draft);

    public Draft findDraftById(Integer id);
}
