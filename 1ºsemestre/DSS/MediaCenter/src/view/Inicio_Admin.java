package view;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import MVC.View;
import business.Utilizador.Utilizador;

import javax.swing.*;
import java.io.*;
import java.net.Socket;
import java.util.List;

/**
 *
 * @author xaLuG
 */
public class Inicio_Admin extends javax.swing.JFrame implements View {

    /**
     * Creates new form Inicio_Admin
     */
    public Inicio_Admin(Socket s) {
        initComponents();
        this.socket=s;
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        logout_button = new javax.swing.JButton();
        criar_button = new javax.swing.JButton();
        remover_button = new javax.swing.JButton();
        jLabel3 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        logout_button.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        logout_button.setText("Logout");
        logout_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                logout_buttonActionPerformed(evt);
            }
        });

        criar_button.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        criar_button.setText("Criar Conta");
        criar_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                criar_buttonActionPerformed(evt);
            }
        });

        remover_button.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        remover_button.setText("Remover Conta");
        remover_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                remover_buttonActionPerformed(evt);
            }
        });

        jLabel3.setIcon(new javax.swing.ImageIcon(System.getProperty("user.dir")+ File.separator
                +"src"+File.separator+"view"+File.separator+"icons"+File.separator+"mediacenter.png")); // NOI18N

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addContainerGap(68, Short.MAX_VALUE)
                                .addComponent(jLabel3)
                                .addGap(57, 57, 57))
                        .addGroup(layout.createSequentialGroup()
                                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                        .addComponent(remover_button, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addComponent(criar_button, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addComponent(logout_button, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(layout.createSequentialGroup()
                                .addContainerGap()
                                .addComponent(jLabel3)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 50, Short.MAX_VALUE)
                                .addComponent(criar_button)
                                .addGap(33, 33, 33)
                                .addComponent(remover_button)
                                .addGap(31, 31, 31)
                                .addComponent(logout_button)
                                .addGap(28, 28, 28))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void logout_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_logout_buttonActionPerformed
        try {
            PrintWriter pw = new PrintWriter(this.socket.getOutputStream());
            pw.println("terminarSessao");
            pw.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            String res = br.readLine();
            if (!res.equals("Sucesso")){
                JOptionPane.showMessageDialog(this, "Ocorreu um erro a interpretar a mensagem");
                return;
            }
        }
        catch (IOException e){
            JOptionPane.showMessageDialog(this, "Erro de conexão");
            return;
        }
        new Menu_Inicial(this.socket).run();
        this.setVisible(false);
        dispose();
    }//GEN-LAST:event_logout_buttonActionPerformed

    private void criar_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_criar_buttonActionPerformed
        new Registar(this.socket).run();
        this.setVisible(false);
        dispose();
    }//GEN-LAST:event_criar_buttonActionPerformed

    private void remover_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_remover_buttonActionPerformed
        try {
            PrintWriter pw = new PrintWriter(this.socket.getOutputStream());
            pw.println("getListaUsers");
            pw.flush();
            ObjectInputStream input = new ObjectInputStream(this.socket.getInputStream());
            List<Utilizador> list = (List<Utilizador>) input.readObject();
            new Lista_Users(this.socket,list).run();
            this.setVisible(false);
            dispose();
        }
        catch (IOException | ClassNotFoundException e){
            JOptionPane.showMessageDialog(this, "Erro de conexão");
        }
    }//GEN-LAST:event_remover_buttonActionPerformed


    public void run() {
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        this.setVisible(true);
    }

    Socket socket;
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton criar_button;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JButton logout_button;
    private javax.swing.JButton remover_button;
    // End of variables declaration//GEN-END:variables
}
