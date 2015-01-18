using System;
using System.Collections.Generic;
using System.Text;
using Saga.Shared.PacketLib;
using Saga.Network.Packets;

namespace Saga.Packets
{


    /// <summary>
    /// 
    /// </summary>
    /// <remarks>
    /// This packet is sent to the client to activate a item that has 
    /// an skill. Example items would be potions.
    /// </remarks>
    /// <id>
    /// 090A
    /// </id>
    internal class CMSG_ITEMTOGLE : RelayPacket
    {
        public CMSG_ITEMTOGLE()
        {
            this.data = new byte[11];
        }

        public byte SkillType
        {
            get { return this.data[0]; }
        }

        public byte Container
        {
            get { return this.data[1]; }
        }

        public byte Index
        {
            get { return this.data[2]; }
        }

        public uint SkillID
        {
            get { return BitConverter.ToUInt32(this.data, 3); }
        }

        public uint TargetActor
        {
            get { return BitConverter.ToUInt32(this.data, 7); }
        }

        #region Conversions

        public static explicit operator CMSG_ITEMTOGLE(byte[] p)
        {
            /*
            // Creates a new byte with the length of data
            // plus 4. The first size bytes are used like
            // [PacketSize][PacketId][PacketBody]
            //
            // Where Packet Size equals the length of the 
            // Packet body, Packet Identifier, Packet Size 
            // Container.
            */

            CMSG_ITEMTOGLE pkt = new CMSG_ITEMTOGLE();
            pkt.data = new byte[p.Length - 14];
            pkt.session = BitConverter.ToUInt32(p, 2);
            Array.Copy(p, 6, pkt.cmd, 0, 2);
            Array.Copy(p, 12, pkt.id, 0, 2);
            Array.Copy(p, 14, pkt.data, 0, p.Length - 14);
            return pkt;
        }

        #endregion
    }
}