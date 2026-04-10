package com.buildtrack.service;

public class ClientService {
    private final ClientDAO clientDAO= new ClientDAO();

    public List<Client> getAll() {return clientDAO.findAll();}
    public Client getByUserId(int userId) {return clientDAO.findByUserId(userId);}
    public Client getById(int id) {return clientDAO.findById(id);}
    public boolean create(client client) {return clientDAO.insert(client)>0;}
    public boolean update(client client) {return clientDAO.update(client);}
}
